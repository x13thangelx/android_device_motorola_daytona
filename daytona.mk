#
# Copyright (C) 2009 The Android Open Source Project
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

#
# This is the product configuration for a generic CDMA daytona,
# not specialized for any geography.
#

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

DEVICE_PACKAGE_OVERLAYS += device/motorola/daytona/overlay

## (1) First, the most specific values, i.e. the aspects that are specific to CDMA
# Rootfs
# there are 3 init.rcs
# 1. init.rc: the stock init.rc with mot users
# 2. init.daytona.rc: our device specific init.rc
# 3. init.daytona.usb.rc: usb changes for init.rc
PRODUCT_COPY_FILES += \
    device/motorola/daytona/root/init.daytona.rc:root/init.daytona.rc \
    device/motorola/daytona/root/init.daytona.usb.rc:root/init.daytona.usb.rc \
    device/motorola/daytona/root/ueventd.daytona.rc:root/ueventd.daytona.rc \
    device/motorola/daytona/root/init.rc:root/init.rc \
    device/motorola/daytona/root/sbin/fixboot.sh:root/sbin/fixboot.sh \
    device/motorola/daytona/root/sbin/2nd-init:root/sbin/2nd-init \
    device/motorola/daytona/root/sbin/taskset:root/sbin/taskset \
    device/motorola/daytona/root/sbin/strace:root/sbin/strace

## (2) Also get non-open-source CDMA-specific aspects if available
$(call inherit-product-if-exists, vendor/motorola/daytona/daytona-vendor.mk)

# sysctl conf
PRODUCT_COPY_FILES += \
    device/motorola/daytona/prebuilts/etc/sysctl.conf:system/etc/sysctl.conf

## (3)  Finally, the least specific parts, i.e. the non-CDMA-specific aspects

# Set en_US as default locale
PRODUCT_LOCALES := en_US

# daytona uses high-density artwork where available
PRODUCT_LOCALES += hdpi

# high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_PACKAGES := \
    charger \
    charger_res_images

# copy all kernel modules under the "modules" directory to system/lib/modules
PRODUCT_COPY_FILES += $(shell \
    find device/motorola/daytona/modules -name '*.ko' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
    | tr '\n' ' ')

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/motorola/daytona/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES += \
    audio.primary.daytona \
    camera.daytona

# BlueZ a2dp Audio HAL module
PRODUCT_PACKAGES += \
    audio.a2dp.default

# Modem
PRODUCT_PACKAGES += \
    libaudiomodemgeneric \
    libreference-cdma-sms \
    rild \
    radiooptions \

# Wifi
PRODUCT_PACKAGES += \
    libCustomWifi \
    wlan_loader \
    wlan_cu \
    dhcpcd.conf \
    wpa_supplicant.conf \

# Release utilities
PRODUCT_PACKAGES += \
    daytona_releaseutils-check_kernel \
    daytona_releaseutils-finalize_release \
    daytona_releaseutils-mke2fs \
    daytona_releaseutils-tune2fs \


PRODUCT_PACKAGES += \
    DockAudio \
    Camera \
    Superuser \
    su \
    Usb \
    CMSettings


PRODUCT_PACKAGES += \
    librs_jni \
    com.android.future.usb.accessory \
    libjni_pinyinime \

# Board-specific init
PRODUCT_COPY_FILES += \
    device/motorola/daytona/prebuilts/etc/vold.fstab:system/etc/vold.fstab \
    device/motorola/daytona/init.vsnet:system/bin/init.vsnet \
    device/motorola/daytona/scripts/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh \
    device/motorola/daytona/prebuilts/liba2dp.so:system/lib/liba2dp.so \
    #device/motorola/daytona/config/media_profiles.xml:system/etc/media_profiles.xml \

#keyboard files
PRODUCT_COPY_FILES += \
    device/motorola/daytona/keylayout/tegra-kbc.kl:system/usr/keylayout/tegra-kbc.kl \
    device/motorola/daytona/keychars/tegra-kbc.kcm.bin:system/usr/keychars/tegra-kbc.kcm.bin \
    device/motorola/daytona/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl \
    device/motorola/daytona/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/motorola/daytona/keylayout/qtouch-obp-ts.kl:system/usr/keylayout/qtouch-obp-ts.kl \
    device/motorola/daytona/prebuilts/idc/qtouch-obp-ts.idc:system/usr/idc/qtouch-obp-ts.idc \
    device/motorola/daytona/keylayout/Motorola_Mobility_Motorola_HD_Dock.kl:system/usr/keylayout/Motorola_Mobility_Motorola_HD_Dock.kl \
    device/motorola/daytona/keylayout/cpcap-key.kl:system/usr/keylayout/cpcap-key.kl \
    device/motorola/daytona/keylayout/evfwd.kl:system/usr/keylayout/evfwd.kl \
    device/motorola/daytona/keylayout/usb_keyboard_102_en_us.kl:system/usr/keylayout/usb_keyboard_102_en_us.kl \
    device/motorola/daytona/keychars/usb_keyboard_102_en_us.kcm.bin:system/usr/keychars/usb_keyboard_102_en_us.kcm.bin \
    device/motorola/daytona/keylayout/usb_keyboard_102_en_us.kl:system/usr/keylayout/Motorola_Bluetooth_Wireless_Keyboard.kl \
    device/motorola/daytona/keychars/usb_keyboard_102_en_us.kcm.bin:system/usr/keychars/Motorola_Bluetooth_Wireless_Keyboard.kcm.bin

# Permission files
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PACKAGES += \
	hijack-boot.zip

# Hijack files
PRODUCT_COPY_FILES += \
	$(DEVICE_PREBUILT)/etc/hijack-boot.zip:system/etc/hijack-boot.zip

#$(call inherit-product, device/motorola/daytona/hijack/daytona-hijack.mk)

$(call inherit-product-if-exists, vendor/motorola/daytona/daytona-vendor.mk)

$(call inherit-product, build/target/product/full_base_telephony.mk)

PRODUCT_NAME := Gummy_daytona
PRODUCT_DEVICE := daytona
PRODUCT_MODEL := MB870
