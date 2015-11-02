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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The GPS configuration appropriate for this device.
#$(call inherit-product, device/common/gps/gps_eu_supl.mk)

DEVICE_PACKAGE_OVERLAYS += device/jsr/d9/overlay

PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_TAGS += dalvik.gc.type-precise

# Ramdisk
PRODUCT_PACKAGES += fstab.qcom
PRODUCT_PACKAGES += init.qcom.rc
PRODUCT_PACKAGES += init.qcom.usb.rc
PRODUCT_PACKAGES += init.target.rc
PRODUCT_PACKAGES += ueventd.qcom.rc
PRODUCT_PACKAGES += init.qcom.ril.sh

# Rootdir
PRODUCT_PACKAGES += device/jsr/d9/rootdir/fstab.qcom:root/fstab.qcom
PRODUCT_PACKAGES += device/jsr/d9/rootdir/init.qcom.rc:root/init.qcom.rc
PRODUCT_PACKAGES += device/jsr/d9/rootdir/init.qcom.usb.rc:root/init.qcom.usb.rc
PRODUCT_PACKAGES += device/jsr/d9/rootdir/init.target.rc:root/init.target.rc
PRODUCT_PACKAGES += device/jsr/d9/rootdir/ueventd.qcom.rc:root/ueventd.qcom.rc
PRODUCT_PACKAGES += device/jsr/d9/rootdir/init.qcom.ril.sh:root/init.qcom.ril.sh

# FM
#PRODUCT_PACKAGES += FM2
#PRODUCT_PACKAGES += FMRecord
#PRODUCT_PACKAGES += libqcomfm_jni
#PRODUCT_PACKAGES += qcom.fmradio

# Torch
PRODUCT_PACKAGES += Torch

# Packages
PRODUCT_PACKAGES += audio.a2dp.default
PRODUCT_PACKAGES += audio.primary.msm7x27a
PRODUCT_PACKAGES += audio.usb.default
PRODUCT_PACKAGES += audio_policy.msm7x27a
PRODUCT_PACKAGES += libaudioutils

PRODUCT_PACKAGES += libgenlock
PRODUCT_PACKAGES += copybit.msm7x27a
PRODUCT_PACKAGES += gralloc.msm7x27a
PRODUCT_PACKAGES += libqdMetaData
PRODUCT_PACKAGES += memtrack.msm7x27a
PRODUCT_PACKAGES += hwcomposer.msm7x27a
PRODUCT_PACKAGES += libtilerenderer

PRODUCT_PACKAGES += librs_jni
PRODUCT_PACKAGES += LiveWallpapers
PRODUCT_PACKAGES += LiveWallpapersPicker
PRODUCT_PACKAGES += VisualizationWallpapers

PRODUCT_PACKAGES += libmm-omxcore
PRODUCT_PACKAGES += libOmxCore
PRODUCT_PACKAGES += libstagefrighthw

PRODUCT_PACKAGES += gps.msm7x27a
#PRODUCT_PACKAGES += camera.msm7x27a 
#PRODUCT_PACKAGES += lights.msm7x27a

PRODUCT_PACKAGES += com.android.future.usb.accessory
PRODUCT_PACKAGES += hwmac
PRODUCT_PACKAGES += make_ext4fs
PRODUCT_PACKAGES += setup_fs

# WebKit
#PRODUCT_PACKAGES += libwebcore

# wifi
PRODUCT_PACKAGES += libwpa_client
PRODUCT_PACKAGES += hostapd
PRODUCT_PACKAGES += dhcpcd.conf
PRODUCT_PACKAGES += wpa_supplicant
PRODUCT_PACKAGES += wpa_supplicant.conf


# Files
PRODUCT_COPY_FILES += device/jsr/d9/configs/qosmgr_rules.xml:system/etc/qosmgr_rules.xml

PRODUCT_COPY_FILES += device/jsr/d9/configs/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf
PRODUCT_COPY_FILES += device/jsr/d9/configs/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf
PRODUCT_COPY_FILES += device/jsr/d9/configs/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf
PRODUCT_COPY_FILES += device/jsr/d9/configs/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

#PRODUCT_COPY_FILES += frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml
#PRODUCT_COPY_FILES += frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml
#PRODUCT_COPY_FILES += frameworks/av/media/libstagefright/data/media_codecs_google_video_le.xml:system/etc/media_codecs_google_video_le.xml

PRODUCT_COPY_FILES += device/jsr/d9/configs/audio_policy.conf:system/etc/audio_policy.conf
PRODUCT_COPY_FILES += device/jsr/d9/configs/media_codecs.xml:system/etc/media_codecs.xml
PRODUCT_COPY_FILES += device/jsr/d9/configs/media_profiles.xml:system/etc/media_profiles.xml

#PRODUCT_COPY_FILES += device/jsr/d9/idc/qwerty.idc:system/usr/idc/qwerty.idc
#PRODUCT_COPY_FILES += device/jsr/d9/idc/qwerty2.idc:system/usr/idc/qwerty2.idc
PRODUCT_COPY_FILES += device/jsr/d9/keychars/7x27a_kp.kcm:system/usr/keychars/7x27a_kp.kcm
PRODUCT_COPY_FILES += device/jsr/d9/keylayout/7x27a_kp.kl:system/usr/keylayout/7x27a_kp.kl
PRODUCT_COPY_FILES += device/jsr/d9/keylayout/surf_keypad.kl:system/usr/keylayout/surf_keypad.kl

# ETC
PRODUCT_PACKAGES += device/jsr/d9/configs/AudioFilter.csv:system/etc/AudioFilter.csv
PRODUCT_PACKAGES += device/jsr/d9/configs/init.qcom.fm.sh:system/etc/init.qcom.fm.sh
PRODUCT_PACKAGES += device/jsr/d9/configs/thermald.conf:system/etc/thermald.conf

# Keylayout
PRODUCT_PACKAGES += device/jsr/d9/keylayout/7k_handset.kl:system/usr/keylayout/7k_handset.kl
PRODUCT_PACKAGES += device/jsr/d9/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl
PRODUCT_PACKAGES += device/jsr/d9/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl
PRODUCT_PACKAGES += device/jsr/d9/keylayout/ft5x06_ts.kl:system/usr/keylayout/ft5x06_ts.kl
PRODUCT_PACKAGES += device/jsr/d9/keylayout/Generic.kl:system/usr/keylayout/Generic.kl

# Permissions
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml
PRODUCT_COPY_FILES += frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml
#PRODUCT_COPY_FILES += packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
#PRODUCT_PACKAGES += frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml
#PRODUCT_PACKAGES += frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml

# Properties
PRODUCT_PROPERTY_OVERRIDES += headset.hook.delay=500

PRODUCT_PROPERTY_OVERRIDES += ro.bluetooth.remote.autoconnect=true
PRODUCT_PROPERTY_OVERRIDES += ro.bluetooth.request.master=true
PRODUCT_PROPERTY_OVERRIDES += ro.bt.bdaddr_path=/data/misc/bluedroid/bdaddr
PRODUCT_PROPERTY_OVERRIDES += ro.qualcomm.bluetooth.dun=true
PRODUCT_PROPERTY_OVERRIDES += ro.qualcomm.bluetooth.ftp=true

PRODUCT_PROPERTY_OVERRIDES += ro.cwm.enable_key_repeat=true

PRODUCT_PROPERTY_OVERRIDES += debug.composition.type=dyn
PRODUCT_PROPERTY_OVERRIDES += debug.hwc.dynThreshold=1.9
PRODUCT_PROPERTY_OVERRIDES += persist.hwc.mdpcomp.enable=false
PRODUCT_PROPERTY_OVERRIDES += debug.mdpcomp.logs=0
PRODUCT_PROPERTY_OVERRIDES += debug.gralloc.map_fb_memory=1
PRODUCT_PROPERTY_OVERRIDES += debug.hwc.fakevsync=1
#PRODUCT_PROPERTY_OVERRIDES += ro.bq.gpu_to_cpu_unsupported=1
PRODUCT_PROPERTY_OVERRIDES += ro.max.fling_velocity=4000
PRODUCT_PROPERTY_OVERRIDES += ro.opengles.version=131072
PRODUCT_PROPERTY_OVERRIDES += ro.sf.lcd_density=240

PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapgrowthlimit=48m
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.heapsize=128m
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true

PRODUCT_PROPERTY_OVERRIDES += com.qc.hardware=true
PRODUCT_PROPERTY_OVERRIDES += dev.pm.dyn_sample_period=700000
PRODUCT_PROPERTY_OVERRIDES += dev.pm.dyn_samplingrate=1
PRODUCT_PROPERTY_OVERRIDES += ro.vendor.extension_library=/system/lib/libqc-opt.so

PRODUCT_PROPERTY_OVERRIDES += ril.subscription.types=NV,RUIM
PRODUCT_PROPERTY_OVERRIDES += rild.libargs=-d/dev/smd0
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.call_ring.delay=3000
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.call_ring.multiple=false

PRODUCT_PROPERTY_OVERRIDES += persist.sys.usb.config=mtp,adb
PRODUCT_PROPERTY_OVERRIDES += ro.vold.umsdirtyratio=50

#PRODUCT_PROPERTY_OVERRIDES += persist.webview.provider=classic

PRODUCT_PROPERTY_OVERRIDES += wifi.interface=wlan0
PRODUCT_PROPERTY_OVERRIDES += wifi.supplicant_scan_interval=60

PRODUCT_PROPERTY_OVERRIDES += ro.confg.hw_appfsversion=d9V4_4_SYSIMG
PRODUCT_PROPERTY_OVERRIDES += ro.confg.hw_appsbootversion=d9V4_4_APPSBOOT
PRODUCT_PROPERTY_OVERRIDES += ro.confg.hw_appversion=d9V4_4_KERNEL

PRODUCT_PROPERTY_OVERRIDES += ro.fm.analogpath.supported=false
PRODUCT_PROPERTY_OVERRIDES += ro.fm.transmitter=false
PRODUCT_PROPERTY_OVERRIDES += ro.fm.mulinst.recording.support=false

PRODUCT_PROPERTY_OVERRIDES += gsm.version.baseband=2030
PRODUCT_PROPERTY_OVERRIDES += rild.libpath=/system/lib/libril-qc-qmi-1.so
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.ril.config=qcomdsds,skippinpukcount,signalstrength
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.ril.v3=qcomdsds,skippinpukcount
PRODUCT_PROPERTY_OVERRIDES += ro.telephony.ril_class=JSRQualcommRIL

# Audio
PRODUCT_PROPERTY_OVERRIDES += audio.gapless.playback.disable=true
PRODUCT_PROPERTY_OVERRIDES += audio.offload.disable=1

# Low RAM
PRODUCT_PROPERTY_OVERRIDES += ro.config.low_ram=true
PRODUCT_PROPERTY_OVERRIDES += config.disable_atlas=true
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.jit.codecachesize=0
PRODUCT_PROPERTY_OVERRIDES += persist.sys.force_highendgfx=true
PRODUCT_PROPERTY_OVERRIDES += ro.config.max_starting_bg=8
PRODUCT_PROPERTY_OVERRIDES += ro.sys.fw.bg_apps_limit=16
    
# FM Radio
PRODUCT_PROPERTY_OVERRIDES += ro.fm.analogpath.supported=false
PRODUCT_PROPERTY_OVERRIDES += ro.fm.transmitter=false
PRODUCT_PROPERTY_OVERRIDES += ro.fm.mulinst.recording.support=false

# Stagefright
PRODUCT_PROPERTY_OVERRIDES += media.stagefright.enable-player=true
PRODUCT_PROPERTY_OVERRIDES += media.stagefright.enable-meta=false
PRODUCT_PROPERTY_OVERRIDES += media.stagefright.enable-scan=true
PRODUCT_PROPERTY_OVERRIDES += media.stagefright.enable-http=true
PRODUCT_PROPERTY_OVERRIDES += media.stagefright.enable-fma2dp=true
PRODUCT_PROPERTY_OVERRIDES += media.stagefright.enable-aac=true
PRODUCT_PROPERTY_OVERRIDES += media.stagefright.enable-qcp=true

PRODUCT_PROPERTY_OVERRIDES += mm.enable.smoothstreaming=true

# Newer camera API isn't supported.
PRODUCT_PROPERTY_OVERRIDES += camera2.portability.force_api=1

# Use ART small mode
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.dex2oat-filter=balanced
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.dex2oat-flags=--no-watch-dog
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.image-dex2oat-filter=speed

# ART properties
ADDITIONAL_DEFAULT_PROPERTIES += dalvik.vm.dex2oat-Xms=8m
ADDITIONAL_DEFAULT_PROPERTIES += dalvik.vm.dex2oat-Xmx=96m
ADDITIONAL_DEFAULT_PROPERTIES += dalvik.vm.image-dex2oat-Xms=48m
ADDITIONAL_DEFAULT_PROPERTIES += dalvik.vm.image-dex2oat-Xmx=48m


# default.prop
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.adb.secure=0
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.secure=0


#$(call inherit-product, $(SRC_TARGET_DIR)/product/full.mk)

$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

$(call inherit-product, vendor/jsr/common-vendor.mk)
$(call inherit-product, vendor/jsr/d9-vendor.mk)
