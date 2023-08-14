#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Rootdir
PRODUCT_PACKAGES += \
    VibCali_ship.sh \
    init.asus.audbg.sh \
    hs_driver_ver.sh \
    init.qti.chg_policy.sh \
    ufs_info.sh \
    init.asus.check_last.sh \
    init.qti.kernel.debug-yupik.sh \
    savelogmtp.sh \
    PanelFrameRate.sh \
    init.qcom.post_boot.sh \
    init.qcom.class_core.sh \
    init.asus.checkaudbg.sh \
    WifiMac.sh \
    touch_ver.sh \
    init.asus.check_asdf.sh \
    disableSavelogPermissive.sh \
    init.asus.last_logcat.sh \
    firmware_version.sh \
    select_output.sh \
    country.sh \
    saveTZQSEE.sh \
    init.qti.display_boot.sh \
    antennaSwitchSvc.sh \
    gf_ver.sh \
    ddr_info.sh \
    init.qti.media.sh \
    antennaSwap.sh \
    init.asus.piq.sh \
    init.kernel.post_boot-yupik.sh \
    LcdPanel_VendorID.sh \
    init.qcom.sensors.sh \
    WifiSARPower.sh \
    init.qcom.usb.sh \
    init.mdm.sh \
    bktp_touch_ver.sh \
    cscclearlog.sh \
    init.qcom.early_boot.sh \
    init.asus.ramdump.sh \
    init.asus.kernelmessage.sh \
    create_pcbid.sh \
    vendor_modprobe.sh \
    systrace.sh \
    hs_fw_ver.sh \
    parse.simcode.sh \
    wifistresstest.sh \
    savelogs.sh \
    pmodechange.sh \
    mount_apd.sh \
    init.kernel.post_boot-lahaina.sh \
    headset_status.sh \
    init.crda.sh \
    init.asus.zram.sh \
    LightFingerprintPosition.sh \
    savelogs_complete.sh \
    cscSecdisplay.sh \
    erase_batinfo.sh \
    init.qcom.sdio.sh \
    init.asus.checklogsize.sh \
    init.qcom.sh \
    cat_pcbid.sh \
    grip_fpc_check.sh \
    select_mic.sh \
    init.kernel.post_boot-shima.sh \
    ssr_cfg.sh \
    UTSdumpstate.sh \
    init.asus.changebinder.sh \
    init.class_main.sh \
    init.qti.kernel.debug.sh \
    qca6234-service.sh \
    grip_cal.sh \
    WifiAntenna.sh \
    widevine.sh \
    init.asus.checkdatalog.sh \
    init.kernel.post_boot.sh \
    procrankdump.sh \
    init.asus.boot_vibrator.sh \
    init.qti.kernel.debug-shima.sh \
    init.qcom.coex.sh \
    execkernelevt.sh \
    sensors_factory_init.sh \
    saveramdump.sh \
    init.qcom.efs.sync.sh \
    init.asus.thermal_conf.sh \
    inbox_headset_status.sh \
    init.qti.qcv.sh \
    rcv_amp_cal_val.sh \
    init.asus.writeversion.sh \
    spk_amp_cal_val.sh \
    init.qti.kernel.sh \
    BLPower.sh \
    prepare_asusdebug.sh \
    init.qti.kernel.debug-lahaina.sh \

PRODUCT_PACKAGES += \
    fstab.emmc \
    init.asus.debugtool.rc \
    init.asus.rc \
    init.qcom.factory.rc \
    init.asus.usb.rc \
    init.target.rc \
    init.qti.kernel.rc \
    init.qcom.rc \
    init.qti.ufs.rc \
    init.recovery.qcom.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.emmc:$(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk/fstab.emmc

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 30

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/asus/anakin/anakin-vendor.mk)
