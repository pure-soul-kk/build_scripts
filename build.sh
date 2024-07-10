#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs --depth=1
git clone https://github.com/pure-soul-kk/local_manifest -b rising .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
fi

#custom repos
rm -rf prebuilts/clang/host/linux-x86/clang-r498229b
git clone --depth=1 https://gitlab.com/itsshashanksp/android_prebuilts_clang_host_linux-x86_clang-r498229b.git -b 13.0 prebuilts/clang/host/linux-x86/clang-r498229b
rm -rf hardware/xiaomi
git clone https://github.com/pure-soul-kk/hardware_xiaomi hardware/xiaomi
rm -rf vendor/lineage
git clone --depth=1 https://github.com/AOSP-Sweet-Trees/android_vendor_lineage vendor/lineage
rm -rf vendor/lineage-priv/keys
git clone --depth=1 https://github.com/pure-soul-kk/private-keys -b lineage vendor/lineage-priv/keys

#build
. build/envsetup.sh
riseup sweet user
mka installclean
rise b
