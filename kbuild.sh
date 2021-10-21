# entry point
set -exo pipefail
function fail {
ECODE=$1
shift
echo "ERROR:" "$@"
exit $ECODE
}
export KBUILDER_ROOT="$(pwd)"
if [ ! -d "${WORKSPACE}" ]; then
echo "WARNING: jenkins workspace not found. Assuming default directory is workspace!"
cd ..
export WORKSPACE="$(pwd)"
fi
cd "${WORKSPACE}"
[ -d "${KERNEL_DIR}" ] || fail 1 "Kernel source directory not found. Did you configure the jenkins git intergration?"
# set up crosscompiler
source "${KBUILDER_ROOT}/compilerdb.sh"
if [ "x$ARCH" != "x" ]; then
  export CROSS_COMPILE=$(pwd)/${Compiler}-${ARCH}/$(eval "echo \${prefix_${ARCH}_${Compiler}}")
fi
if [ "x$HAS_VDSO32" == "xtrue" ]; then
  if [ "x$ARCH" == "xarm64" ]; then
    export CROSS_COMPILE_ARM32=$(pwd)/${Compiler}-arm/$(eval "echo \${prefix_arm_${Compiler}}")
  fi
  export CROSS_COMPILE_VDSO32=$(pwd)/${Compiler}-${VDSO_ARCH}/$(eval "echo \${prefix_${VDSO_ARCH}_${Compiler}}")
fi
# defconfig will trigger clean build
if [ "x$Clean" == "xfalse" ]; then
  export DEFCONFIG=""
fi
# build
cd "${WORKSPACE}/${KERNEL_DIR}"
[ -d "${MAKE_OUT}" ] || mkdir -p "${MAKE_OUT}"
[ "x$Clean" == "xproper" ] && make "O=${MAKE_OUT}" mrproper
[ "x$Clean" == "xproper" ] && make "O=${MAKE_OUT}" clean
[ "x$Clean" == "xtrue" ] && make "O=${MAKE_OUT}" clean
[ "x$DEFCONFIG" == "x" ] || make "O=${MAKE_OUT}" "${DEFCONFIG}"
make "O=${MAKE_OUT}" -j${MAKE_THREADS}
cd "${KBUILDER_ROOT}"
export PKG_OUTDIR="${WORKSPACE}/${KERNEL_DIR}/${MAKE_OUT}"
if [ "x$PACKAGER" != "x" ]; then
  for i in $PACKAGERS; do
    source "packagers/${i}.sh"
   done
fi
