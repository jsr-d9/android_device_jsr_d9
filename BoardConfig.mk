#
# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).
# The proprietary variant sets USE_CAMERA_STUB := false, this way
# we use the camera stub when the vendor tree isn't present, and
# the true camera library when the vendor tree is available.
USE_CAMERA_STUB := true

# Inherit from the proprietary version
-include vendor/jsr/d9/BoardConfigVendor.mk
-include vendor/jsr/msm7x27a-common/BoardConfigVendor.mk

BOARD_VENDOR := jsr-qcom

# Assert
TARGET_OTA_ASSERT_DEVICE := d9,msm8625_d9,msm8225_d9,Boost

# Compile sys
TARGET_GCC_VERSION_EXP := 4.8
DISABLE_DEXPREOPT := true
#TARGET_SPECIFIC_HEADER_PATH := device/jsr/d9/include

# Compiler flags
#COMMON_GLOBAL_CFLAGS += -DQCOM_BSP_ABI_HACK
COMMON_GLOBAL_CFLAGS += -DQCOM_BSP
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a5 -mfpu=neon-vfpv4 -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a5 -mfpu=neon-vfpv4 -mfloat-abi=softfp

# Qualcomm hardware
BOARD_USES_QCOM_HARDWARE := true
COMMON_GLOBAL_CFLAGS += -DUSE_MDP3
COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE
TARGET_USES_ION := true
TARGET_USES_QCOM_BSP := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := 7x27
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Architecture and CPU
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a5
TARGET_BOARD_PLATFORM := msm7x27a
TARGET_CPU_SMP := true

# GPU
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200
#BOARD_USES_ADRENO_200 := true

# Optimisations
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true
TARGET_CORTEX_CACHE_LINE_32 := true
TARGET_AVOID_DRAW_TEXTURE_EXTENSION := true
TARGET_USES_16BPPSURFACE_FOR_OPAQUE := true
ARCH_ARM_HIGH_OPTIMIZATION := true
ARCH_ARM_HAVE_32_BYTE_CACHE_LINES := true
TARGET_GRALLOC_USES_ASHMEM := true

# Kernel
TARGET_KERNEL_CONFIG := jsr_d9_defconfig
BOARD_KERNEL_BASE := 0x00200000
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.selinux=permissive user_debug=31 debug ignore_loglevel pmemlog=3 reboot=2
BOARD_PAGE_SIZE := 2048
TARGET_KERNEL_SOURCE := kernel/jsr/msm8625

# These currently have to go to the ramdisk for wlan_detect to pick them up.
# Hopefully they can join their friends at $(KERNEL_MODULES_OUT) soon. :(
KERNEL_EXTERNAL_MODULES:
	mkdir -p $(TARGET_ROOT_OUT)/wifi
	rm -rf $(TARGET_OUT_INTERMEDIATES)/ath6kl
	cp -a hardware/atheros/wifi/ath6kl $(TARGET_OUT_INTERMEDIATES)/
	$(MAKE) -C $(TARGET_OUT_INTERMEDIATES)/ath6kl/cfg80211 KERNEL_OUT=$(KERNEL_OUT) ARCH="arm" CROSS_COMPILE="arm-eabi-" modules
	$(MAKE) -C $(TARGET_OUT_INTERMEDIATES)/ath6kl/ar6000 KERNEL_OUT=$(KERNEL_OUT) ARCH="arm" CROSS_COMPILE="arm-eabi-" modules
	$(TARGET_OBJCOPY) --strip-unneeded $(TARGET_OUT_INTERMEDIATES)/ath6kl/cfg80211/cfg80211.ko $(TARGET_ROOT_OUT)/wifi/cfg80211.ko
	$(TARGET_OBJCOPY) --strip-unneeded $(TARGET_OUT_INTERMEDIATES)/ath6kl/ar6000/ar6000.ko $(TARGET_ROOT_OUT)/wifi/ar6000.ko

TARGET_KERNEL_MODULES := KERNEL_EXTERNAL_MODULES

# Partitions
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 471859200
BOARD_USERDATAIMAGE_PARTITION_SIZE := 984961024
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 13901824
BOARD_CACHEIMAGE_PARTITION_SIZE := 104857600

BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_USERIMAGES_USE_EXT4 := true

BOARD_CACHE_DEVICE := /dev/block/mmcblk0p18
BOARD_CACHE_FILESYSTEM := ext4
BOARD_CACHE_FILESYSTEM_OPTIONS := rw

BOARD_SYSTEM_DEVICE := /dev/block/mmcblk0p17
BOARD_SYSTEM_FILESYSTEM := ext4
BOARD_SYSTEM_FILESYSTEM_OPTIONS := rw

BOARD_DATA_DEVICE := /dev/block/mmcblk0p21
BOARD_DATA_FILESYSTEM := ext4
BOARD_DATA_FILESYSTEM_OPTIONS := rw

# Dalvik
TARGET_ARCH_LOWMEM := true

# Low RAM settings
MALLOC_IMPL := dlmalloc
TARGET_BOOTANIMATION_TEXTURE_CACHE := false
AUDIO_FEATURE_ENABLED_INCALL_MUSIC := false
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP := false
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := false

# Audio
TARGET_PROVIDES_LIBAUDIO := true
BOARD_USES_LEGACY_ALSA_AUDIO := true
TARGET_HAS_QACT := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/jsr/d9/bluetooth

# FM
#BOARD_HAVE_QCOM_FM := true
#COMMON_GLOBAL_CFLAGS += -DQCOM_FM_ENABLED
#AUDIO_FEATURE_ENABLED_FM := true

# GPS
QCOM_GPS_PATH := hardware/qcom/gps
BOARD_USES_QCOM_GPS := true
BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 50000
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)

# Graphics
BOARD_ADRENO_DECIDE_TEXTURE_TARGET := true
BOARD_EGL_CFG := device/jsr/d9/configs/egl.cfg
#BOARD_EGL_WORKAROUND_BUG_10194508 := true
#BOARD_USE_MHEAP_SCREENSHOT := true
#TARGET_DOESNT_USE_FENCE_SYNC := true
#TARGET_QCOM_DISPLAY_VARIANT := legacy
TARGET_QCOM_DISPLAY_VARIANT := caf
USE_OPENGL_RENDERER := true
TARGET_DISPLAY_USE_RETIRE_FENCE := true
HWUI_COMPILE_FOR_PERF := true

# Camera
#COMMON_GLOBAL_CFLAGS += -DMR0_CAMERA_BLOB -DNEEDS_VECTORIMPL_SYMBOLS
USE_DEVICE_SPECIFIC_CAMERA := true
#USE_CAMERA_STUB :=false

# Other
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
BOARD_CHARGER_ENABLE_SUSPEND := true
#BOARD_HAL_STATIC_LIBRARIES := libhealthd.msm7x27a
ARCH_ARM_HAVE_TLS_REGISTER := true
BOARD_WANTS_EMMC_BOOT := true

# RIL
BOARD_RIL_CLASS := ../../../device/jsr/d9/ril/

# Hardware
BOARD_HARDWARE_CLASS := device/jsr/d9/cmhw

# Lights
TARGET_PROVIDES_LIBLIGHTS := true

# Media
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
#TARGET_ENABLE_AV_ENHANCEMENTS := false
#TARGET_QCOM_MEDIA_VARIANT := legacy
TARGET_QCOM_MEDIA_VARIANT := caf
#TARGET_QCOM_LEGACY_MMPARSER := true
COMMON_GLOBAL_CFLAGS += -DQCOM_NO_SECURE_PLAYBACK
COMMON_GLOBAL_CFLAGS += -DLPA_DEFAULT_BUFFER_SIZE=480

# SELinux
BOARD_SEPOLICY_DIRS += device/jsr/d9/sepolicy

BOARD_SEPOLICY_UNION += file_contexts
BOARD_SEPOLICY_UNION += app.te
BOARD_SEPOLICY_UNION += file.te

# USB
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
BOARD_VOLD_MAX_PARTITIONS := 22
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/class/android_usb/android0/f_mass_storage/lun%d/file
TARGET_USE_CUSTOM_SECOND_LUN_NUM := 1

# Web Rendering
#ENABLE_WEBGL := true
#PRODUCT_PREBUILT_WEBVIEWCHROMIUM := yes
#TARGET_FORCE_CPU_UPLOAD := true

# Recovery
#TARGET_NO_RECOVERY := true
#TARGET_NO_SEPARATE_RECOVERY := false
#RECOVERY_VARIANT := cm
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_RECOVERY_SWIPE := true
BOARD_SUPPRESS_EMMC_WIPE := true
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
DEVICE_RESOLUTION := 540x960
BOARD_CUSTOM_GRAPHICS := ../../../device/jsr/d9/recovery/graphics.c
TARGET_RECOVERY_FSTAB := device/jsr/d9/recovery/recovery.fstab
#BOARD_CUSTOM_RECOVERY_KEYMAPPING := ../../device/jsr/d9/recovery/recovery-keys.c
#BOARD_UMS_LUNFILE := /sys/class/android_usb/android0/f_mass_storage/lun%d/file
#TARGET_RECOVERY_INITRC := device/jsr/d9/recovery/init.rc
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Wi-Fi
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
#TARGET_CUSTOM_WIFI := ../../device/jsr/d9/libhardware_legacy/wifi/wifi.c
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HAS_ATH_WLAN := true
BOARD_WLAN_DEVICE := ath6kl
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_AP := "ap"
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_P2P := "p2p"
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/ath6kl/ath6kl_sdio.ko"
WIFI_DRIVER_MODULE_NAME := "wlan"
WIFI_EXT_MODULE_PATH := "/system/lib/modules/ath6kl/cfg80211.ko"
WIFI_EXT_MODULE_NAME := "cfg80211"
WIFI_DRIVER_FW_PATH_PARAM := "/data/misc/wifi/fwpath"

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),userdebug)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif
WITH_DEXPREOPT_PIC := true
DONT_DEXPREOPT_PREBUILTS := true
 
# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# Enable Minikin text layout engine (will be the default soon)
USE_MINIKIN := true
 