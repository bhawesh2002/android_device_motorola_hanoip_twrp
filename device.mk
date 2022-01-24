#
# Copyright 2020 The Android Open Source Project
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

# define hardware platform
PRODUCT_PLATFORM := sm6150
PLATFORM_PATH := device/motorola/hanoip

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B support
AB_OTA_UPDATER := true

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
    boot \
    vendor_boot \
    system \
    vbmeta \
    dtbo \
    product \
    vbmeta_system \
    system_ext

# Use Sdcardfs
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sys.sdcardfs=1

PRODUCT_COPY_FILES += \
    $(PLATFORM_PATH)/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.$(PRODUCT_PLATFORM) \
    $(PLATFORM_PATH)/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.$(PRODUCT_PLATFORM) \
    $(PLATFORM_PATH)/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.$(PRODUCT_PLATFORM) \

# Use /product/etc/fstab.postinstall to mount system_other
PRODUCT_PRODUCT_PROPERTIES += \
    ro.postinstall.fstab.prefix=/product

PRODUCT_COPY_FILES += \
    $(PLATFORM_PATH)/fstab.postinstall:$(TARGET_COPY_OUT_PRODUCT)/etc/fstab.postinstall

PRODUCT_COPY_FILES += \
   	$(PLATFORM_PATH)/recovery/root/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc

# A/B support
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier

PRODUCT_PACKAGES += \
    e2fsck_ramdisk \
    tune2fs_ramdisk \
    resize2fs_ramdisk

PRODUCT_PACKAGES += \
    bootctrl.sm6150 \
    bootctrl.sm6150.recovery

PRODUCT_PACKAGES += \
    update_engine_sideload \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

PRODUCT_PACKAGES_DEBUG += \
    bootctl \
    r.vendor \
    update_engine_client

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITIPLATFORM_PATHON_LIST := true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.qcom.boot@1.1-impl \
    android.qcom.boot@1.1-service \
    android.qcom.boot@1.1-impl-wrapper.recovery \
    android.qcom.boot@1.1-impl-wrapper \
    android.qcom.boot@1.1-impl.recovery \

# Memtrack HAL
PRODUCT_PACKAGES += \
    memtrack.sm6150 \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service

# DRM HAL
PRODUCT_PACKAGES += \
    android.hardware.drm@1.3-service.clearkey \
    android.hardware.drm@1.3-service.widevine

PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl-qti \
    android.hardware.health@2.1-service

# Storage health HAL
PRODUCT_PACKAGES += \
<<<<<<< HEAD
    android.hardware.health.storage@1.0

PRODUCT_PACKAGES += \
    fstab.qcom \

PRODUCT_PACKAGES += \
    fs_config_dirs \
=======
>>>>>>> 48d3b6569f9ad45664aed8a074eab9f6ce1932e0
    fs_config_files
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1 \
    android.hardware.identity-support-lib
 
# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Keymaster configuration
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml \


# Apex libraries
PRODUCT_HOST_PACKAGES += \
    libandroidicu

# qcom standard decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

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

# Apex libraries
PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libandroidicu.so


PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2021-09-01   
    
PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.volume.filenames_mode=aes-256-cts

# Storage: for factory reset protection feature
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/bootdevice/by-name/frp
