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
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

PLATFORM_PATH := device/motorola/hanoip

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sm6150
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := sm6150
TARGET_BOARD_PLATFORM_GPU := qcom-adreno618
TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true
BUILD_BROKEN_DUP_RULES := true
QCOM_BOARD_PLATFORMS += sm6150

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9


# GPT Utils
BOARD_PROVIDES_GPTUTILS := true

# Kernel
BOARD_KERNEL_CMDLINE += console=ttyMSM0,115200n8 androidboot.console=ttyMSM0 printk.devkmsg=on
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += androidboot.memcg=1 androidboot.hardware=qcom androidboot.force_normal_boot=1 androidboot.bootdevice=1d84000.ufshc androidboot.boot_devices=soc/1d84000.ufshc
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += video=vfb:640x400,bpp=32,memsize=3072000
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3 swiotlb=2048
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += earlycon=msm_geni_serial,0x880000
BOARD_KERNEL_CMDLINE += androidboot.hab.csv=5
BOARD_KERNEL_CMDLINE += androidboot.hab.product=hanoip
BOARD_KERNEL_CMDLINE += androidboot.hab.cid=50
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware_mnt/image
BOARD_KERNEL_CMDLINE += buildvariant=user
BOARD_KERNEL_CMDLINE += androidboot.keymaster=1
BOARD_KERNEL_CMDLINE += androidboot.vbmeta.device=PARTUUID=53fd77d8-b172-9209-9061-9355a75e8b9b
BOARD_KERNEL_CMDLINE += androidboot.vbmeta.avb_version=1.0
BOARD_KERNEL_CMDLINE += androidboot.vbmeta.device_state=unlocked
BOARD_KERNEL_CMDLINE += androidboot.vbmeta.hash_alg=sha256
BOARD_KERNEL_CMDLINE += androidboot.vbmeta.size=6464
BOARD_KERNEL_CMDLINE += androidboot.vbmeta.digest=94c13e24836a893accfd1a9883b9fe896cad58ad61387c0074250adb75a0a85a
BOARD_KERNEL_CMDLINE += androidboot.veritymode=enforcing
BOARD_KERNEL_CMDLINE += androidboot.fastboot=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 3
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_DTBOIMG_PARTITION_SIZE := 25165824

#kernel source
#TARGET_KERNEL_SOURCE := kernel/motorola/hanoip
#TARGET_KERNEL_CONFIG := vendor/hanoip_defconfig

# prebuilts
BOARD_PREBUILT_DTBIMAGE_DIR := $(PLATFORM_PATH)/prebuilt/dtb
TARGET_PREBUILT_KERNEL := $(PLATFORM_PATH)/prebuilt/kernel
BOARD_PREBUILT_DTBOIMAGE := $(PLATFORM_PATH)/prebuilt/dtbo.img
BOARD_KERNEL_SEPARATED_DT := true
TARGET_KERNEL_ADDITIONAL_FLAGS := \
    DTC=$(shell pwd)/$(PLATFORM_PATH)/dtc/dtc

# kernel build info
#TARGET_KERNEL_VERSION := 4.14.190-perf
#TARGET_KERNEL_ARCH := arm64
#TARGET_KERNEL_HEADER_ARCH := arm64

#clang
#use if building with clang
#TARGET_KERNEL_CLANG_COMPILE := true
#TARGET_KERNEL_CLANG_VERSION := r383902b  # clang version for Android R release

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1


# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE  := 67108864
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 536870912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 115921629184
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

BOARD_RAMDISK_USE_LZ4 := true

#fstab
TARGET_RECOVERY_WIPE := device/motorola/hanoip/recovery.wipe
TARGET_RECOVERY_FSTAB := device/motorola/hanoip/fstab.qcom

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# persist.img
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4

# product.img
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_PRODUCTIMAGE := true
TARGET_COPY_OUT_PRODUCT := product

# system_ext.img
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# Specify BOOT_KERNEL_MODULES
#
# modules for first stage in vendor_boot.img, remainder goes to vendor.img.
# This list is a superset of all the possible modules required, and is
# filtered and ordered as per the supplied kernel's modules.load file.
# Any modules that do not exist will be silently dropped.  This is required
# because some kernel configurations may have extra debug or test modules,
# make sure any required to be loaded during first stage init are listed.

BOOT_KERNEL_MODULES := \
	audio_apr.ko \
	audio_snd_event.ko \
	audio_wglink.ko \
	audio_q6_pdr.ko \
	audio_q6_notifier.ko \
	audio_adsp_loader.ko \
	audio_q6.ko \
	audio_usf.ko \
	audio_pinctrl_wcd.ko \
	audio_pinctrl_lpi.ko \
	audio_swr.ko \
	audio_wcd_core.ko \
	audio_swr_ctrl.ko \
	audio_wsa881x.ko \
	audio_platform.ko \
	audio_hdmi.ko \
	audio_stub.ko \
	audio_wcd9xxx.ko \
	audio_mbhc.ko \
	audio_wcd934x.ko \
	audio_wcd937x.ko \
	audio_wcd937x_slave.ko \
	audio_bolero_cdc.ko \
	audio_wsa_macro.ko \
	audio_va_macro.ko \
	audio_rx_macro.ko \
	audio_tx_macro.ko \
	audio_wcd_spi.ko \
	audio_native.ko \
	audio_machine_talos.ko \
	mpq-adapter.ko \
	mpq-dmx-hw-plugin.ko \
	qca_cld3_wlan.ko \
	rdbg.ko \
	exfat.ko \
	mmi_sys_temp.ko \
	sensors_class.ko \
	utags.ko \
	moto_f_usbnet.ko \
	watchdogtest.ko \
	mmi_info.ko \
	mmi_annotate.ko \
	tzlog_dump.ko \
	watchdog_cpu_ctx.ko \
	fpsensor_spi_tee.ko \
	fpc1020_mmi.ko \
	ilitek_v3_mmi.ko \
	sx933x_sar.ko \
	snd_smartpa_aw882xx.ko \
	qpnp_adaptive_charge.ko 
	
#symlink folders
BOARD_ROOT_EXTRA_SYMLINKS := /vendor/lib/dsp:/dsp
BOARD_ROOT_EXTRA_SYMLINKS += /mnt/vendor/persist:/persist

# Super
BOARD_SUPER_PARTITION_SIZE := 10804527104
BOARD_SUPER_PARTITION_GROUPS := motorola_dynamic_partitions
#BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE is set to BOARD_SUPER_PARTITION_SIZE / 2 - 4MB
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 5398069248
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product \
    vendor \
    system_ext 

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_INCLUDE_RECOVERY_DTBO := false
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

TARGET_USES_MKE2FS := true

# A/B device flags
AB_OTA_UPDATER := true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# Kernel modules
KERNEL_MODULE_DIR := $(PLATFORM_PATH)/recovery/root/vendor/lib/modules
KERNEL_MODULES := $(wildcard $(KERNEL_MODULE_DIR)/*.ko)
KERNEL_MODULES_LOAD := $(KERNEL_MODULE_DIR)/modules.load
BOARD_VENDOR_KERNEL_MODULES := $(KERNEL_MODULES)
OARD_VENDOR_KERNEL_MODULES_LOAD := $(KERNEL_MODULES_LOAD)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(KERNEL_MODULES)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(KERNEL_MODULES_LOAD)
RECOVERY_KERNEL_MODULES := $(BOOT_KERNEL_MODULES)

# Encryption
PLATFORM_VERSION := 16.1.0
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
TARGET_USES_HARDWARE_QCOM_BOOTCTRL := true

# Extras
TARGET_SYSTEM_PROP += $(PLATFORM_PATH)/system.prop

BOARD_SUPPRESS_SECURE_ERASE := true


TARGET_USES_LOGD := true

ALLOW_MISSING_DEPENDENCIES := true

# Debug flags
TWRP_INCLUDE_LOGCAT := true
# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.base@1.0 \
    ashmemd \
    ashmemd_aidl_interface-cpp \
    libashmemd_client \
    libcap \
    libicuuc \
    libion \
    libpcrecpp \
    libprocinfo \
    libxml2

TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES += \
    $(TARGET_OUT_EXECUTABLES)/ashmemd

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicuuc.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libprocinfo.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so


# TWRP specific build flags
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_RESETPROP := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_MAX_BRIGHTNESS := 400
TW_DEFAULT_BRIGHTNESS := 225
TW_INCLUDE_CRYPTO := true
TW_THEME := portrait_hdpi
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file"
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/qcom_battery"
TW_NO_CPU_TEMP := true
TW_NO_SCREEN_BLANK := true
TW_USE_TOOLBOX := true
TW_HAS_EDL_MODE := true
TW_EXTRA_LANGUAGES := true
# Notch Offset
TW_Y_OFFSET := 120
TW_H_OFFSET := -120
# Asian region languages
TW_EXTRA_LANGUAGES := true
# TW_DEFAULT_LANGUAGE := zh_CN
