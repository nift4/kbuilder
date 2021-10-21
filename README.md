# kbuilder
Jenkins kernel build script
## Usage
Define Jenkins parameter "selection" `Compiler` with the values
```
lineagegcc
evagcc
evagccnew
```
Define Jenkins parameter "boolean" `Clean`.
Copy-paste the following script and adjust the variables:
```
export KBUILDER_REPO="nift4/kbuilder" # kbuilder repo
export KBUILDER_BRANCH="master" # kbuilder branch
export KERNEL_DIR="kernel" # path where kernel sources are put by jenkins
export MAKE_PARAMS="O=out" # extra make parameters - default: set output directory to `out`
export MAKE_THREADS="$(nproc --all)" # how many threads to use - default: automatically determinate

### kbuilder initialization, do not change ###
[ -d kbuilder ] || git clone "https://github.com/$KBUILDER_REPO" -b "$KBUILDER_BRANCH" kbuilder
cd kbuilder
git reset --hard
git clean -fd
git pull --ff-only
source kbuild.sh
```
