#!/bin/bash
# Pack the kernel into an AnyKernel3 ZIP
# Required variables:
#  AK3_ZIP_NAME - zip name of resulting zip
#  AK3_REPO_URL - full git repository url
#  AK3_REPO_BRANCH - full git repository url
# Optional variables:
#  AK3_KEEP_OUTDIR - copy files into new outdir to upload them
rm -rf "${WORKSPACE}/anykernel3_out"
mkdir "${WORKSPACE}/anykernel3_out"
rm -rf "${WORKSPACE}/anykernel3_tmp"
git clone "${AK3_REPO_URL}" --depth 1 -b "${AK3_REPO_BRANCH}" "${WORKSPACE}/anykernel3_tmp"
cd "${WORKSPACE}/anykernel3_tmp"
cp -r $PKG_OUTDIR/* .
zip -r9 "${WORKSPACE}/anykernel3_out/${AK3_ZIP_NAME}" * -x .git README.md *placeholder
if [ "x$AK3_KEEP_OUTDIR" == "xtrue" ]; do
  cp -r "$PKG_OUTDIR/*" "${WORKSPACE}/anykernel3_out/"
fi
cd - >/dev/null
export PKG_OUTDIR="${WORKSPACE}/anykernel3_out"
