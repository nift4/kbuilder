# Grab Image.gz
rm -rf "${WORKSPACE}/grabimagegz_out/"
mkdir "${WORKSPACE}/grabimagegz_out/"
cp "$PKG_OUTDIR/arch/$ARCH/boot/Image.gz" "${WORKSPACE}/grabimagegz_out/Image.gz"
export PKG_OUTDIR="${WORKSPACE}/grabimagegz_out"
