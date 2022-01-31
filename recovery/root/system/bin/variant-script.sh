#!/system/bin/sh
# automatically set device props for unified tree shared-hardware models/variants


load_motog40()
{
    resetprop "ro.build.product" "hanoip"
    resetprop "ro.product.device" "hanoip"
    resetprop "ro.product.model" "moto g(40) fusion"
    resetprop "ro.product.name" "hanoip_retail"
    resetprop "ro.product.odm.device" "hanoip"
    resetprop "ro.product.odm.model" "moto g(60)"
    resetprop "ro.product.odm.name" "hanoip_retail"
    resetprop "ro.product.product.device" "hanoip"
    resetprop "ro.product.product.model" "moto g(60)"
    resetprop "ro.product.product.name" "hanoip_retail"
    resetprop "ro.product.system.device" "hanoip"
    resetprop "ro.product.system.model" "moto g(60)"
    resetprop "ro.product.system.name" "hanoip_retail"
    resetprop "ro.product.system_ext.device" "hanoip"
    resetprop "ro.product.system_ext.model" "moto g(60)"
    resetprop "ro.product.system_ext.name" "hanoip_retail"
    resetprop "ro.product.vendor.device" "hanoip"
    resetprop "ro.product.vendor.model" "moto g(60)"
    resetprop "ro.product.vendor.name" "hanoip_retail"
}

load_motog60()
{
    resetprop "ro.build.product" "hanoip"
    resetprop "ro.product.device" "hanoip"
    resetprop "ro.product.model" "moto g(60)"
    resetprop "ro.product.name" "hanoip_retail"
    resetprop "ro.product.odm.device" "hanoip"
    resetprop "ro.product.odm.model" "moto g(60)"
    resetprop "ro.product.odm.name" "hanoip_retail"
    resetprop "ro.product.product.device" "hanoip"
    resetprop "ro.product.product.model" "moto g(60)"
    resetprop "ro.product.product.name" "hanoip_retail"
    resetprop "ro.product.system.device" "hanoip"
    resetprop "ro.product.system.model" "moto g(60)"
    resetprop "ro.product.system.name" "hanoip_retail"
    resetprop "ro.product.system_ext.device" "hanoip"
    resetprop "ro.product.system_ext.model" "moto g(60)"
    resetprop "ro.product.system_ext.name" "hanoip_retail"
    resetprop "ro.product.vendor.device" "hanoip"
    resetprop "ro.product.vendor.model" "moto g(60)"
    resetprop "ro.product.vendor.name" "hanoip_retail"
}

project=$(getprop ro.build.product)
echo "Running unified/variant script with $project..." >> /tmp/recovery.log

case $project in
    hanoip*)
        load_motog40
        ;;
    *)
        load_motog60
        ;;
esac

exit 0


