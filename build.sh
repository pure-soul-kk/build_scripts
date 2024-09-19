#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/c0smic-Lab/manifest.git -b 15 --git-lfs --depth=1
git clone https://github.com/pure-soul-kk/local_manifest -b c15 .repo/local_manifests
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
fi

#custom repos
# rm -rf prebuilts/clang/host/linux-x86/clang-r498229b
# git clone --depth=1 https://gitlab.com/itsshashanksp/android_prebuilts_clang_host_linux-x86_clang-r498229b.git -b 13.0 prebuilts/clang/host/linux-x86/clang-r498229b
rm -rf hardware/xiaomi
git clone -b vic https://github.com/pure-soul-kk/hardware_xiaomi hardware/xiaomi
rm -rf vendor/extra
git clone https://github.com/pure-soul-kk/vendor_extra vendor/extra
rm -rf frameworks/av
git clone --depth=1 https://github.com/pure-soul-kk/frameworks_av frameworks/av
rm -rf hardware/lineage/compat
git clone https://github.com/pure-soul-kk/hardware_lineage_compat.git hardware/lineage/compat
rm -rf vendor/lineage-priv/keys
git clone --depth=1 https://github.com/pure-soul-kk/private-keys -b lineage vendor/lineage-priv/keys

export WITH_GMS=true

#build
. build/envsetup.sh
lunch aosp_sweet-ap3a-user
mka installclean
mka bacon
