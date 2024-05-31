#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs --depth=1
git clone https://github.com/pure-soul-kk/local_manifest -b pixelos .repo/local_manifests
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
rm -rf vendor/extra
git clone https://github.com/pure-soul-kk/vendor_extra vendor/extra
rm -rf frameworks/base
git clone --depth=1 https://github.com/AOSP-Sweet-Trees/android_frameworks_base frameworks/base
rm -rf frameworks/av
git clone --depth=1 https://github.com/AOSP-Sweet-Trees/android_frameworks_av frameworks/av
rm -rf packages/apps/Settings
git clone --depth=1 https://github.com/AOSP-Sweet-Trees/android_packages_apps_Settings packages/apps/Settings
rm -rf frameworks/opt/telephony
git clone --depth=1 https://github.com/AOSP-Sweet-Trees/frameworks_opt_telephony frameworks/opt/telephony
rm -rf vendor/aosp
git clone --depth=1 https://github.com/AOSP-Sweet-Trees/vendor_aosp vendor/aosp
rm -rf vendor/aosp/signing/keys
git clone https://github.com/pure-soul-kk/private-keys vendor/aosp/signing/keys

#build
. build/envsetup.sh
lunch aosp_sweet-ap2a-user
mka installclean
mka bacon
