

CFG_FILE=$1

while IFS= read -r var
do
if [[ "$var" =~ ^VIVPRJ=(.*$) ]] ; then
VIVPRJ=${BASH_REMATCH[1]}
echo "VIBPRJ=$VIVPRJ"
fi
if [[ "$var" =~ ^VIVPRJNAME=(.*$) ]] ; then
VIVPRJNAME=${BASH_REMATCH[1]}
echo "VIVPRJNAME=$VIVPRJNAME"
fi
if [[ "$var" =~ ^TOPLEVELNAME=(.*$) ]] ; then
TOPLEVELNAME=${BASH_REMATCH[1]}
echo "TOPLEVELNAME=$TOPLEVELNAME"
fi
if [[ "$var" =~ ^LINUXREPO=(.*$) ]] ; then
LINUXREPO=${BASH_REMATCH[1]}
echo "LINUXREPO=$LINUXREPO"
fi
if [[ "$var" =~ ^IMAGENAME=(.*$) ]] ; then
IMAGENAME=${BASH_REMATCH[1]}
echo "IMAGENAME=$IMAGENAME"
fi
if [[ "$var" =~ ^BUILDDIR=(.*$) ]] ; then
BUILDDIR=${BASH_REMATCH[1]}
echo "BUILDDIR=$BUILDDIR"
fi
if [[ "$var" =~ ^BUILDNAME=(.*$) ]] ; then
BUILDNAME=${BASH_REMATCH[1]}
echo "BUILDNAME=$BUILDNAME"
fi
if [[ "$var" =~ ^XSDKDIR=(.*$) ]] ; then
XSDKDIR=${BASH_REMATCH[1]}
echo "XSDKDIR=$XSDKDIR"
fi
if [[ "$var" =~ ^DTREPO=(.*$) ]] ; then
DTREPO=${BASH_REMATCH[1]}
echo "DTREPO=$DTREPO"
fi
if [[ "$var" =~ ^VIVADOVER=(.*$) ]] ; then
VIVADOVER=${BASH_REMATCH[1]}
echo "VIVADOVER=$VIVADOVER"
fi
if [[ "$var" =~ ^UBOOTPATH=(.*$) ]] ; then
UBOOTPATH=${BASH_REMATCH[1]}
echo "UBOOTPATH=$UBOOTPATH"
fi
done < "$CFG_FILE"

source xbuild.sh $VIVPRJ $VIVPRJNAME $TOPLEVELNAME $LINUXREPO $IMAGENAME $BUILDDIR $BUILDNAME $XSDKDIR $DTREPO $UBOOTPATH $VIVADOVER
