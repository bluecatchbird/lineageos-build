#!/bin/bash

## need a home var, otherwise ninja want to write to root(/)
export HOME=/opt/home
mkdir -p $HOME

## init 
repo init -u https://github.com/LineageOS/android.git -b lineage-15.1


## add needed vendor data, see:
## https://github.com/LineageOS/android_device_xiaomi_msm8953-common/issues/1
LOCAL_MANIFEST=/opt/android/lineage/.repo/local_manifests/roomservice.xml
if ! grep TheMuppets $LOCAL_MANIFEST >/dev/null
then
    PROJECT='<project name="TheMuppets/proprietary_vendor_xiaomi" path="vendor/xiaomi" remote="github" />'
    MANIFEST_END='</manifest>'
    sed -i "s,$MANIFEST_END,${PROJECT}\n${MANIFEST_END}," $LOCAL_MANIFEST
fi

## sync all
repo sync -j32 --force-sync -c

export USE_CCACHE=1
export CCACHE_DIR=/opt/ccache
ccache -M 50G

. build/envsetup.sh
breakfast lineage_tissot-userdebug

# need to set env var USER, because "jack" needs it
export USER=builduser
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

## for cleanup
mka clobber

## build
mka otatools-package target-files-package dist
