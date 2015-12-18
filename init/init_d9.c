#include <stdlib.h>
#include <stdio.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mount.h>


#include "init_msm.h"

#define PERSISTENT_PROPERTY_DIR  "/data/property"

void init_msm_properties(unsigned long msm_id, unsigned long msm_ver, char * board_type)
{
	UNUSED(msm_id);
	UNUSED(msm_ver);
	UNUSED(board_type);
	
	char value[PROP_VALUE_MAX];
	int rc;
	
	DIR * dir = opendir(PERSISTENT_PROPERTY_DIR);
	int dir_fd;
	struct dirent * entry;
	int fd, length;
	struct stat sb;

	if (dir) {
		dir_fd = dirfd(dir);
		while ((entry = readdir(dir)) != NULL) {
			int skip = 1;
			// we need to read this properties before load_persistent_properties()
			if (!strncmp("persist.zram.planned_size", entry->d_name, strlen("persist.zram.planned_size")))
				skip = 0;
			if (!strncmp("persist.storages.planned_swap", entry->d_name, strlen("persist.storages.planned_swap")))
				skip = 0;
			if (skip)
				continue;
#if HAVE_DIRENT_D_TYPE
			if (entry->d_type != DT_REG)
				continue;
#endif
			/* open the file and read the property value */
			fd = openat(dir_fd, entry->d_name, O_RDONLY | O_NOFOLLOW);
			if (fd < 0) {
				ERROR("Unable to open persistent property file \"%s\" errno: %d\n", entry->d_name, errno);
				continue;
			}
			if (fstat(fd, &sb) < 0) {
				ERROR("fstat on property file \"%s\" failed errno: %d\n", entry->d_name, errno);
				close(fd);
				continue;
			}

			// File must not be accessible to others, be owned by root/root, and
			// not be a hard link to any other file.
			if (((sb.st_mode & (S_IRWXG | S_IRWXO)) != 0)
				      || (sb.st_uid != 0)
				      || (sb.st_gid != 0)
				      || (sb.st_nlink != 1)) {
				ERROR("skipping insecure property file %s (uid=%u gid=%u nlink=%d mode=%o)\n",
				      entry->d_name, (unsigned int)sb.st_uid, (unsigned int)sb.st_gid,
				      sb.st_nlink, sb.st_mode);
				close(fd);
				continue;
			}

			length = read(fd, value, sizeof(value) - 1);
			if (length >= 0) {
				value[length] = 0;
				property_set(entry->d_name, value);
			} else {
				ERROR("Unable to read persistent property file %s errno: %d\n", entry->d_name, errno);
			}
			close(fd);
		}
		closedir(dir);
	} else {
		ERROR("Unable to open persistent property directory %s errno: %d\n", PERSISTENT_PROPERTY_DIR, errno);
	}
	
	mount("rootfs", "/", "rootfs", MS_REMOUNT|0, NULL);
	
	rc = property_get("persist.storages.planned_swap", value);
	if (rc && atoi(value)) {
		// if swapped
		property_set("persist.storages.swapped", "1");
		property_set("ro.storage_list.override", "storage_list_swapped");
		symlink("/fstab.extsd", "/fstab.qcom");
		symlink("/storage/sdcard0", "/mnt/sdcard");
		symlink("/storage/sdcard0", "/sdcard");
		symlink("/storage/sdcard1", "/mnt/internal_sd");
		symlink("/storage/sdcard1", "/internal_sd");
	} else {
		// if not swapped
		property_set("persist.storages.swapped", "0");
		symlink("/fstab.emmc", "/fstab.qcom");
		symlink("/storage/sdcard0", "/mnt/internal_sd");
		symlink("/storage/sdcard0", "/internal_sd");
		symlink("/storage/sdcard1", "/mnt/sdcard");
		symlink("/storage/sdcard1", "/sdcard");
	}

	mount("rootfs", "/", "rootfs", MS_REMOUNT|MS_RDONLY, NULL);

	rc = property_get("persist.zram.planned_size", value);
	if (!rc) {
		property_set("persist.zram.size", "0");
	} else {
		if (atoi(value) > 0) {
			property_set("persist.zram.size", value);
		}
	}
}
