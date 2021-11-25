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

# define hardware platform
PRODUCT_PLATFORM := sm6150

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.qcom:$(TARGET_COPY_OUT_RECOVERY)/root/first_stage_ramdisk/fstab.qcom \
    $(LOCAL_PATH)/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom \
    $(LOCAL_PATH)/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom \
    $(LOCAL_PATH)/init.recovery.qcom.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.recovery.qcom.rc \
    $(LOCAL_PATH)/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/ueventd.rc \
    
# Use /product/etc/fstab.postinstall to mount system_other
PRODUCT_PRODUCT_PROPERTIES += \
    ro.postinstall.fstab.prefix=/product

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fstab.postinstall:$(TARGET_COPY_OUT_PRODUCT)/etc/fstab.postinstall
    

# Apex libraries
PRODUCT_HOST_PACKAGES += \
    libandroidicu

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

TARGET_COPY_OUT_VENDOR := vendor

PRODUCT_VENDOR_MOVE_ENABLED := true

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# tzdata
PRODUCT_PACKAGES += \
    tzdata_twrp

# Blacklist
PRODUCT_SYSTEM_PROPERTY_BLACKLIST += \
    ro.bootimage.build.date.utc \
    ro.build.date.utc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2021-09-01 \
