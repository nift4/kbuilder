### Compiler database ###
## Helper functions ##
function ensurecompiler {
  [ -d $1-$2 ] || git clone $3 --depth=1 -b $4 $1-$2
  cd $1-$2
  git reset --hard
  git clean -fd
  git pull --ff-only
  cd ..
}
## Compilers ##
# Lineage GCC-4.9 (lineagegcc)
export prefix_arm64_lineagegcc=bin/aarch64-linux-android-
export prefix_arm_lineagegcc=bin/arm-linux-androideabi-
ensurecompiler lineagegcc arm https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 lineage-18.1
ensurecompiler lineagegcc arm64 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 lineage-18.1

# Eva GCC - gcc-master branch (evagcc)
export prefix_arm64_evagcc=bin/aarch64-elf-
export prefix_arm_evagcc=bin/arm-eabi-
ensurecompiler evagcc arm https://github.com/mvaisakh/gcc-arm gcc-master
ensurecompiler evagcc arm64 https://github.com/mvaisakh/gcc-arm64 gcc-master

# Eva GCC - gcc-new branch (evagccnew)
export prefix_arm64_evagccnew=bin/aarch64-elf-
export prefix_arm_evagccnew=bin/arm-eabi-
ensurecompiler evagccnew arm https://github.com/mvaisakh/gcc-arm gcc-new
ensurecompiler evagccnew arm64 https://github.com/mvaisakh/gcc-arm64 gcc-new
