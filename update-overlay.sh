#!/bin/sh

MYABSPATH=$(readlink -f "$0")
PATCHBASE=$(dirname "$MYABSPATH")

cd "$PATCHBASE"

mkdir -p overlay/packages/apps/Settings/res/xml/

xmlstarlet ed \
--insert '/preference-headers/header[@android:id="@+id/about_settings"]' \
--type elem -n header \
--insert '/preference-headers/header[not(@android:id)]' \
--type attr -n android:title -v "@string/device_settings" \
--insert '/preference-headers/header[not(@android:id)]' \
--type attr -n android:icon -v "@drawable/ic_settings_profiles" \
--subnode '/preference-headers/header[not(@android:id)]' \
--type elem -n intent \
--insert '/preference-headers/header[not(@android:id)]/intent' \
--type attr -n android:action -v "android.intent.action.MAIN" \
--insert '/preference-headers/header[not(@android:id)]/intent' \
--type attr -n android:targetPackage -v "com.cyanogenmod.settings.device" \
--insert '/preference-headers/header[not(@android:id)]/intent' \
--type attr -n android:targetClass -v "com.cyanogenmod.settings.device.SettingsActivity" \
--insert '/preference-headers/header[not(@android:id)]' \
--type attr -n android:id -v "@+id/device_settings" \
../../../packages/apps/Settings/res/xml/settings_headers.xml > overlay/packages/apps/Settings/res/xml/settings_headers.xml
