#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/asus/anakin

include build/make/target/board/BoardConfigMainlineCommon.mk

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_dlkm \
    vendor_boot

# AVB
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

BOARD_AVB_VBMETA_SYSTEM := product system system_ext
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a76

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Audio
AUDIO_FEATURE_ENABLED_DLKM := true
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
AUDIO_FEATURE_ENABLED_EXT_AMPLIFIER := true
AUDIO_FEATURE_ENABLED_GEF_SUPPORT := true
AUDIO_FEATURE_ENABLED_GKI := true
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true
AUDIO_FEATURE_ENABLED_PROXY_DEVICE := true
AUDIO_FEATURE_ENABLED_SSR := true
AUDIO_FEATURE_ENABLED_SVA_MULTI_STAGE := true
BOARD_SUPPORTS_OPENSOURCE_STHAL := true
BOARD_SUPPORTS_SOUND_TRIGGER := true
BOARD_USES_ALSA_AUDIO := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := lahaina
TARGET_NO_BOOTLOADER := true

# DTB
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)

# DTBO
BOARD_KERNEL_SEPARATED_DTBO := true

# Display
SOONG_CONFIG_qtidisplay_udfps := true
TARGET_SCREEN_DENSITY := 420

# Kernel
BOARD_KERNEL_CMDLINE := \
    androidboot.console=ttyMSM0 \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    cgroup.memory=nokmem,nosocket \
    console=ttyMSM0,115200n8 \
    ip6table_raw.raw_before_defrag=1 \
    iptable_raw.raw_before_defrag=1 \
    loop.max_part=7 \
    lpm_levels.sleep_disabled=1 \
    msm_rtb.filter=0x237 \
    pcie_ports=compat \
    service_locator.enable=1 \
    swiotlb=0 \
    kpti=off

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_RAMDISK_USE_LZ4 := true

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_USES_GENERIC_KERNEL_IMAGE := true
#TARGET_KERNEL_CONFIG := vendor/$(PRODUCT_DEVICE)_defconfig # Prebuilt kernel for now
TARGET_KERNEL_SOURCE := kernel/asus/sm8350
TARGET_KERNEL_NO_GCC := true

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilts/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilts/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := 
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo.img
BOARD_KERNEL_SEPARATED_DTBO := 
endif

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/prebuilts/modules/vendor,$(TARGET_COPY_OUT_VENDOR)/lib/modules) \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)/prebuilts/modules/vendor_boot,$(TARGET_COPY_OUT_VENDOR_BOOT)/lib/modules)

BOARD_VENDOR_KERNEL_MODULES_LOAD := \ # TODO: Fix prebuilt kernel modules
    tua9001.ko \
    tuner-xc2028.ko \
    xc4000.ko \
    swr_ctrl_dlkm.ko \
    tx_macro_dlkm.ko \
    focaltech_fts_rog2.ko \
    platform_dlkm.ko \
    mt20xx.ko \
    va_macro_dlkm.ko \
    msm_drm.ko \
    wsa883x_dlkm.ko \
    slimbus.ko \
    tea5761.ko \
    tda18250.ko \
    it913x.ko \
    tuner-simple.ko \
    tda18212.ko \
    snd-soc-es928x.ko \
    apr_dlkm.ko \
    fc0012.ko \
    tea5767.ko \
    qcom_edac.kov
    tda18218.ko \
    wsa_macro_dlkm.ko \
    btpower.ko \
    ms51_phone.ko \
    tuner-types.ko \
    hid-aksys.ko \
    slimbus-ngd.ko \
    fc0011.ko \
    focaltech_fts_rog.ko \
    wcd937x_slave_dlkm.ko \
    qm1d1c0042.ko \
    rdbg.ko \
    bt_fm_slim.ko \
    q6_pdr_dlkm.ko \
    qt1010.ko \
    gf_spi.ko \
    lid_2.ko \
    mc44s803.ko \
    mbhc_dlkm.ko \
    q6_dlkm.ko \
    mxl301rf.ko \
    si2157.ko \
    machine_dlkm.ko \
    xc5000.ko \
    snd_event_dlkm.ko \
    tntfs.ko \
    fc0013.ko \
    rx_macro_dlkm.ko \
    bolero_cdc_dlkm.ko \
    tda9887.ko \
    wcd938x_dlkm.ko \
    wcd_core_dlkm.ko \
    swr_dlkm.ko \
    wcd938x_slave_dlkm.ko \
    radio-i2c-rtc6226-qca.ko \
    r820t.ko \
    sx932x_2nd.ko \
    texfat.ko \
    stub_dlkm.ko \
    sx932x.ko \
    fc2580.ko \
    mt2063.ko \
    ms51_backcover.ko \
    swr_haptics_dlkm.ko \
    mt2060.ko \
    wcd9xxx_dlkm.ko \
    qm1d1b0004.ko \
    adsp_loader_dlkm.ko \
    pinctrl_wcd_dlkm.ko \
    llcc_perfmon.ko \
    wcd937x_dlkm.ko \
    sla.ko \
    camera.ko \
    mxl5005s.ko \
    mxl5007t.ko \
    max2165.ko \
    pinctrl_lpi_dlkm.ko \
    cs35l45_i2c_dlkm.ko \
    q6_notifier_dlkm.ko \
    m88rs6000t.ko \
    swr_dmic_dlkm.ko \
    lid.ko \
    mt2266.ko \
    mt2131.ko \
    e4000.ko \
    msi001.ko \
    hdmi_dlkm.ko \
    native_dlkm.ko \
    qca_cld3_wlan.ko \
    qca_cld3_qca6750.ko \
    qca_cld3_qca6390.ko \
    wlan.ko \
    qca_cld3_qca6750.ko \
    qca_cld3_qca6390.ko \
    rmnet_core.ko \
    rmnet_ctl.ko \
    rmnet_offload.ko \
    rmnet_shs.ko

TARGET_MODULE_ALIASES += wlan.ko:qca_cld3_wlan.ko

# Partitions
BOARD_ASUS_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor vendor_dlkm
BOARD_ASUS_DYNAMIC_PARTITIONS_SIZE := 7512192768 # BOARD_SUPER_PARTITION_SIZE - 4MB
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
BOARD_SUPER_PARTITION_GROUPS := asus_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 7516192768

BOARD_ROOT_EXTRA_FOLDERS += batinfo

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x6000000
BOARD_DTBOIMG_PARTITION_SIZE := 0x1800000
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Platform
TARGET_BOARD_PLATFORM := lahaina

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOOT_KERNEL_MODULES := \ # TODO: Fix modules
    msm_drm.ko \
    asus_global_var.ko

BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(BOOT_KERNEL_MODULES)
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.emmc
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 100
TARGET_USERIMAGES_USE_F2FS := true

# Security patch level
VENDOR_SECURITY_PATCH := 2021-08-01

# Inherit the proprietary files
include vendor/asus/anakin/BoardConfigVendor.mk
