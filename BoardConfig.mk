#
# Copyright 2021 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specificTARGET_BOARD_PLATFORM 
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

include build/make/target/board/BoardConfigMainlineCommon.mk

PLATFORM_PATH := device/motorola/hanoip

TARGET_BOARD_PLATFORM := sm6150
USES_DEVICE_MOTOROLA_HANOIP := true

ALLOW_MISSING_DEPENDENCIES := true

#Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a73

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

BUILD_BROKEN_DUP_RULES := true

#KERNEL
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3 swiotlb=2048 loop.max_part=7 cgroup.memory=nokmem,nosocket reboot=panic_warm
#BOARD_KERNEL_CMDLINE := \
#console=ttyMSM0,115200n8 \
#androidboot.force_normal_boot=1 \
#androidboot.hardware=qcom \
#androidboot.console=ttyMSM0 \
#androidboot.memcg=1 \
#lpm_levels.sleep_disabled=1 \
#video=vfb:640x400,bpp=32,memsize=3072000 \
#msm_rtb.filter=0x237 \
#service_locator.enable=1 \
#swiotlb=1 \
#androidboot.usbcontroller=a600000.dwc3 \
#earlycon=msm_geni_serial,0x880000 loop.max_part=7 \
#printk.devkmsg=on \
#androidboot.hab.csv=5 \
#androidboot.hab.product=hanoip \
#androidboot.hab.cid=50 \
#firmware_class.path=/vendor/firmware_mnt/image buildvariant=user

BOARD_BOOTCONFIG += androidboot.boot_devices=soc/1d84000.ufshc

BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_FLASH_BLOCK_SIZE := 262144

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_KERNEL_SEPARATED_DTBO := true

BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_INCLUDE_DTB_IN_BOOTIMG := true

TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
TARGET_NO_KERNEL := false
TARGET_KERNEL_VERSION := 4.14.190
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

#using prebuilts
TARGET_PREBUILT_KERNEL := $(PLATFORM_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/
BOARD_PREBUILT_DTBOIMAGE := $(PLATFORM_PATH)/prebuilt/dtbo.img

BOARD_DTBOIMG_PARTITION_SIZE := 25165824

#Clang
TARGET_KERNEL_CLANG_COMPILE := true
#add if building kernel from source
#TARGET_KERNEL_SOURCE := kernel/motorola/hanoip
#TARGET_KERNEL_CONFIG := vendor/hanoip_defconfig
#TARGET_KERNEL_CLANG_VERSION := r383902b
#TARGET_KERNEL_CLANG_VERSION := r433403


#recovery
TARGET_RECOVERY_WIPE := device/motorola/hanoip/recovery/root/system/etc/recovery.wipe
TARGET_RECOVERY_FSTAB := device/motorola/hanoip/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_DEVICE_MODULES += \
    libandroidicu \
    libcap \
    libion \
    libxml2

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so
# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

#enable dm-defaults
#CONFIG_BLK_INLINE_ENCRYPTION=y
#CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
#CONFIG_DM_DEFAULT_KEY=y
#CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y
#CONFIG_EXT4_ENCRYPTION=y
#CONFIG_F2FS_FS_ENCRYPTION=y
#CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
#CONFIG_CRYPTO_SHA2_ARM64_CE=y

BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# boot.img
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864

# vendor_boot.img
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
# system_ext.img
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# product.img
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_PRODUCTIMAGE := true
TARGET_COPY_OUT_PRODUCT := product

# userdata.img
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 115921629184
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# persist.img
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4

# Allow LZ4 compression
BOARD_RAMDISK_USE_LZ4 := true

TARGET_USES_MKE2FS := true

# dynamic partition
BOARD_SUPER_PARTITION_SIZE := 9729736704
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    vendor \
    product \
    system_ext \
    odm 

#BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE is set to BOARD_SUPER_PARTITION_SIZE / 2 - 4MB
#BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 5398069248

BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 4864868352

# Set error limit to BOARD_SUPER_PARTITON_SIZE - 500MB
#BOARD_SUPER_PARTITION_ERROR_LIMIT := 10280239104

BOARD_HAS_LARGE_FILESYSTEM := true

BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# Encryption
PLATFORM_VERSION := 16.1.0
PLATFORM_SECURITY_PATCH := 2021-09-01
VENDOR_SECURITY_PATCH := 2021-09-01

#decryption
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_QCOM_DECRYPTION := true
TARGET_USES_HARDWARE_QCOM_BOOTCTRL := true

# Extras
TARGET_SYSTEM_PROP += $(PLATFORM_PATH)/system.prop
TARGET_VENDOR_PROP += $(PLATFORM_PATH)/vendor.prop

BOARD_SUPPRESS_SECURE_ERASE := true
TW_EXCLUDE_TWRPAPP := true
TW_HAS_EDL_MODE := true

# GPT Utils
BOARD_PROVIDES_GPTUTILS := true

# Asian region languages
TW_EXTRA_LANGUAGES := true
# TW_DEFAULT_LANGUAGE := zh_CN

# Debug flags
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# TWRP specific build flags
#TW_HAS_NO_RECOVERY_PARTITION := true
TW_LOAD_VENDOR_MODULES := "aw8697.ko ilitek_v3_mmi.ko"
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_CUSTOM_CPU_TEMP_PATH := "/sys/devices/virtual/thermal/thermal_zone50/temp"
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_REPACKTOOLS := true
TW_USE_TOOLBOX := true
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_EXCLUDE_MTP := true
TW_OEM_BUILD := true
TW_INCLUDE_RESETPROP := true
TW_OVERRIDE_SYSTEM_PROPS := \ "ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.product.device=ro.product.system.device;ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name"
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 1200
TW_Y_OFFSET := 91
TW_H_OFFSET := -91
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
