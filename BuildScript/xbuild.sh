set -e
VIVPRJ=$1
VIVPRJNAME=$2
TOPLEVELNAME=$3

LINUXREPO=$4
IMAGENAME=$5

BUILDDIR=$6
BUILDNAME=$7

XSDKDIR=$8

DTREPO=$9
UBOOTPATH=${10}
VIVADOVER=${11}

HDF=${VIVPRJ}/${VIVPRJNAME}.sdk/${TOPLEVELNAME}.hdf

if [ ! -f $HDF ]; then
echo "$HDF file not found"
exit
fi

mkdir -p $BUILDDIR
mkdir -p $BUILDDIR/KIMAGES
mkdir -p $BUILDDIR/KIMAGES/$BUILDNAME
mkdir -p $BUILDDIR/BOOTS
mkdir -p $BUILDDIR/SDKS

cp $LINUXREPO/arch/arm/boot/$IMAGENAME $BUILDDIR/KIMAGES/$BUILDNAME

if [ -d $BUILDDIR/BOOTS/$BUILDNAME ]; then
rm -fr $BUILDDIR/BOOTS/${BUILDNAME}old 
mv $BUILDDIR/BOOTS/$BUILDNAME $BUILDDIR/BOOTS/${BUILDNAME}old
fi

mkdir -p $BUILDDIR/BOOTS/$BUILDNAME

OUTPUTDIR=$BUILDDIR/BOOTS/$BUILDNAME/bootgen_sysfiles
mkdir -p $OUTPUTDIR

echo "UNOOTPATH $UBOOTPATH"
cp $UBOOTPATH $OUTPUTDIR/u-boot.elf

#source SDK PATHS
source $XSDKDIR/$VIVADOVER/settings64.sh


xsct xilscripts/create_bsp.tcl $HDF zynq7 ${BUILDDIR}/SDKS/$BUILDNAME
cp ${BUILDDIR}/SDKS/${BUILDNAME}/${TOPLEVELNAME}FSBL/Debug/${TOPLEVELNAME}FSBL.elf $OUTPUTDIR

cp ${VIVPRJ}/${VIVPRJNAME}.runs/impl_1/${TOPLEVELNAME}.bit $OUTPUTDIR

rm -f $OUTPUTDIR/zynq.bif

echo 'the_ROM_image:' > $OUTPUTDIR/zynq.bif
echo '{' >> $OUTPUTDIR/zynq.bif
echo "[bootloader] $OUTPUTDIR/${TOPLEVELNAME}FSBL.elf" >> $OUTPUTDIR/zynq.bif
echo "$OUTPUTDIR/$TOPLEVELNAME.bit" >> $OUTPUTDIR/zynq.bif
echo "$OUTPUTDIR/u-boot.elf" >> $OUTPUTDIR/zynq.bif
echo '}' >> $OUTPUTDIR/zynq.bif

bootgen -arch zynq -image $OUTPUTDIR/zynq.bif -o $OUTPUTDIR/../BOOT.bin -w -log

xsct xilscripts/gen_dtb.tcl $HDF zynq7 $DTREPO ${BUILDDIR}/SDKS/$BUILDNAME

sed -i s:#include:/include/: ${BUILDDIR}/SDKS/$BUILDNAME/${TOPLEVELNAME}DT/system-top.dts

dtc -I dts -O dtb -i ${BUILDDIR}/SDKS/$BUILDNAME/${TOPLEVELNAME}DT -o $OUTPUTDIR/devicetree.dtb ${BUILDDIR}/SDKS/$BUILDNAME/${TOPLEVELNAME}DT/system-top.dts

cp $OUTPUTDIR/devicetree.dtb $OUTPUTDIR/../devicetree.dtb

dtc -I dtb -O dtb -o $OUTPUTDIR/devicetree.dts $OUTPUTDIR/devicetree.dtb
