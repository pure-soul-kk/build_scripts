#!/bin/bash

#removals
rm -rf .repo/local_manifests

#sync
repo init -u https://github.com/PixelOS-AOSP/manifest.git -b fourteen --git-lfs --depth=1
git clone https://github.com/pure-soul-kk/local_manifest -b pixelos .repo/local_manifests
repo sync -c -j8 --force-sync --no-clone-bundle --no-tags

#custom repos
rm -rf prebuilts/clang/host/linux-x86/clang-r498229b
git clone --depth=1 https://gitlab.com/itsshashanksp/android_prebuilts_clang_host_linux-x86_clang-r498229b.git -b 13.0 prebuilts/clang/host/linux-x86/clang-r498229b

git clone https://github.com/pure-soul-kk/hardware_xiaomi hardware/xiaomi
git clone https://github.com/pure-soul-kk/vendor_extra vendor/extra

#build
. build/envsetup.sh
lunch aosp_sweet-ap1a-user
make installclean
m target-files-package otatools

#sign build
rm -rf sign.sh && wget https://raw.githubusercontent.com/pure-soul-kk/build_scripts/pos/sign.sh && bash sign.sh
