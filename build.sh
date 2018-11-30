#!/bin/bash

set -x
set -e
set -o pipefail

#repo init -u https://github.com/LineageOS/android.git -b lineage-15.1
#repo sync -j32 --force-sync -c

export USE_CCACHE=1
export CCACHE_DIR=/opt/ccache
ccache -M 50G

. build/envsetup.sh
breakfast lineage_tissot-userdebug
