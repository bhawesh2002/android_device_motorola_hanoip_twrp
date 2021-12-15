#
# Copyright 2021 The Android Open Source Project
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


# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

PLATFORM_PATH := device/motorola/hanoip

PRODUCT_SHIPPING_API_LEVEL := 30

PRODUCT_TARGET_VNDK_VERSION := 30

# define hardware platform
PRODUCT_PLATFORM := sm6150

#A/B
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

AB_OTA_UPDATER := true

ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

AB_OTA_PARTITIONS += \
    boot \
    vendor_boot \
    odm \
    vendor \
    system \
    vbmeta \
    dtbo \
    product \
    vbmeta_system \
    system_ext
    
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# qcom decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe \

PRODUCT_COPY_FILES += \
    $(PLATFORM_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/recovery.fstab \
    $(PLATFORM_PATH)/recovery.fstab:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/recovery.fstab \
    $(PLATFORM_PATH)/recovery.fstab:$(TARGET_COPY_OUT_VENDOR)/etc/recovery.fstab \
    
# Use /product/etc/fstab.postinstall to mount system_other
PRODUCT_PRODUCT_PROPERTIES += \
    ro.postinstall.fstab.prefix=/product

PRODUCT_COPY_FILES += \
    $(PLATFORM_PATH)/recovery/root/system/etc/fstab.postinstall:$(TARGET_COPY_OUT_PRODUCT)/etc/fstab.postinstall
    
PRODUCT_COPY_FILES += \
    $(PLATFORM_PATH)/recovery/root/vendor/lib/modules/1.1/aw8646.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/aw8646.ko \
    $(PLATFORM_PATH)/recovery/root/vendor/lib/modules/1.1/ilitek_v3_mmi.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/1.1/ilitek_v3_mmi.ko \

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.boot@1.0-impl-wrapper.recovery \
    android.hardware.boot@1.0-impl-wrapper \
    android.hardware.boot@1.0-impl.recovery \
    bootctrl.$(PRODUCT_PLATFORM) \
    bootctrl.$(PRODUCT_PLATFORM).recovery

# Apex libraries
PRODUCT_HOST_PACKAGES += \
    libandroidicu

PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/hanoip/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(PLATFORM_PATH)/security/ota \

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(PLATFORM_PATH)

# tzdata
PRODUCT_PACKAGES += \
    tzdata_twrp

# Blacklist
PRODUCT_SYSTEM_PROPERTY_BLACKLIST += \
    ro.bootimage.build.date.utc \
    ro.build.date.utc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2021-09-01
