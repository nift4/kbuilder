# kbuilder
Jenkins kernel build script
## Usage
Define Jenkins parameter "selection" `Compiler` with the values
```
lineagegcc
evagcc
evagccnew
```
Define Jenkins parameter "selection" `Clean` with the values
```
proper
true
false
```
Copy-paste the following script and adjust the variables:
```
#!/bin/bash
export KBUILDER_REPO="nift4/kbuilder" # kbuilder repo
export KBUILDER_BRANCH="master" # kbuilder branch
export KERNEL_DIR="kernel" # path where kernel sources are put by jenkins
export MAKE_PARAMS="" # extra make parameters
export MAKE_OUT="out" # output directory
export MAKE_THREADS="$(nproc --all)" # how many threads to use - default: automatically determinate
export ARCH="arm64" # target compile arch - if left empty, cross compiling is disabled
export HAS_VDSO32="false" # has vdso32?
export VDSO_ARCH="arm" # 32-bit equilavent of a 64-bit architecture, unused when HAS_VDSO32 is false
export PACKAGERS="anykernel3 uploadgh" # packager scripts to use, space delimited - for more details, see packagers/ directory - if left empty, none will be used
export DEFCONFIG="" # defconfig to use - if empty, skip setting defconfig

### kbuilder initialization, do not change ###
[ -d kbuilder ] || git clone "https://github.com/$KBUILDER_REPO" -b "$KBUILDER_BRANCH" kbuilder
cd kbuilder
git reset --hard
git clean -fd
git pull --ff-only
source kbuild.sh
```
