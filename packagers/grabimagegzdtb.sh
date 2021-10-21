# Grab Image.gz-dtb
rm -rf "${WORKSPACE}/grabimagegzdtb_out/"
mkdir "${WORKSPACE}/grabimagegzdtb_out/"
cp "$PKG_OUTDIR/arch/$ARCH/boot/Image.gz-dtb" "${WORKSPACE}/grabimagegz_out/Image.gz-dtb"
export PKG_OUTDIR="${WORKSPACE}/grabimagegzdtb_out"
