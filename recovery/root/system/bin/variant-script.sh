#!/system/bin/sh
# This script is needed to automatically set device props.

load_sweet()
{
    resetprop "ro.product.model" "moto g(40) fusion"
    resetprop "ro.product.vendor.model" "moto g(60)"
    resetprop "ro.product.name" "hanoip_retail"
    resetprop "ro.build.product" "hanoip"
    resetprop "ro.product.device" "hanoip"
    resetprop "ro.product.system.device" "hanoip"
    resetprop "ro.product.vendor.device" "hanoip"
    resetprop "ro.vendor.product.device" "hanoip"
}

#TODO : What is This?

#load_sweetin()
#{
#    resetprop "ro.product.model" "M2101K6I"
#    resetprop "ro.product.vendor.model" "M2101K6I"
#    resetprop "ro.product.name" "sweetin"
#    resetprop "ro.build.product" "sweetin"
#    resetprop "ro.product.device" "sweetin"
#    resetprop "ro.product.system.device" "sweetin"
#    resetprop "ro.product.vendor.device" "sweetin"
#    resetprop "ro.vendor.product.device" "sweetin"
#}

variant=$(getprop ro.boot.hwc)
echo $variant

case $variant in
    "GLOBAL")
        load_haniop
        ;;
    "INDIA")
        load_haniop
        ;;
    *)
        load_haniop
        ;;
esac

exit 0
