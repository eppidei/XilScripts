if { $::argc == 3 } {
    set i 1
    foreach arg $::argv {
    	puts "argument $i is $arg"
    	if {$i==1} {
    	set HDF $arg
    	} elseif {$i==2} {
    	set ZARCH $arg
	} elseif {$i==3} {
	set WS $arg
	}
	incr i
    }
} else {
puts "Help Usage argv1 hdf_file argv2 zynq_type argv3 ws_name "
exit
}

setws -switch $WS
#if { [catch {getprojects -type hw} var1]} {
#puts "var1 = $var1"
#} else {
#puts "Listing hw project available in the ws $WS"
#}
#if { [catch {getprojects -type bsp} var2]} {
#puts "var2 = $var2"
#} else {
#puts "Listing bsp project available in the ws $WS"
#}
#if { [catch {getprojects -type app} var3]} {
#puts "var3 = $var3"
#} else {
#puts "Listing sw project available in the ws $WS"
#}

set HDFBASENAME [file rootname [file tail $HDF]]
set BSPNAME ${HDFBASENAME}BSP
set FSBLAPPNAME ${HDFBASENAME}FSBL
#puts " HDFBASENAME=$HDFBASENAME"
if { [catch {openhw $HDFBASENAME} var4] } {
puts "var4 = $var4\n"
createhw -name $HDFBASENAME -hwspec $HDF
openhw $HDF
} else {
updatehw -hw $HDFBASENAME -newhwspec $HDF
puts "Project $HDFBASENAME already exists in $WS ...opening..and updating."
}
if {$ZARCH=="zynq7"} {

set PROC ps7_cortexa9_0
set FSBLTEMPLATE "Zynq FSBL"
set PROCARCH 32
}
#puts "Display $PROC ADDRESS MAP"
#getaddrmap $HDFBASENAME $PROC

#hsi::generate_bsp -hw $HDFBASENAME -proc $PROC -os standalone -compile -dir $OUTDIR
if {  [catch {openbsp $BSPNAME} var5] } {
puts " var5 = $var5/n"
createbsp -name $BSPNAME -proc $PROC -hwproject $HDFBASENAME -os standalone -arch $PROCARCH
openbsp $BSPNAME
} else {
#createbsp -name $BSPNAME -proc $PROC -hwproject $HDFBASENAME -os standalone -arch $PROCARCH
puts " BSP project $BSPNAME already exist ... opening "
}

#createbsp -name ${HDFBASENAME}BSP -proc $PROC -hwproject $HDFBASENAME -os standalone -arch $PROCARCH
#configbsp -bsp $BSPNAME -proc $PROC -append
#configbsp -bsp $BSPNAME -os standalone -append
setlib -bsp $BSPNAME -lib libmetal
setlib -bsp $BSPNAME -lib xilffs
#configbsp -bsp $BSPNAME
#configbsp -bsp $BSPNAME -lib 
regenbsp -bsp $BSPNAME
projects -name $BSPNAME -type bsp -build 

if { [catch { createapp -name $FSBLAPPNAME -app $FSBLTEMPLATE -os standalone -proc $PROC -hwproject $HDFBASENAME -lang C -bsp $BSPNAME -arch $PROCARCH} var6 ] }  {
puts " var6 = $var6/n"
}
configapp -app $FSBLAPPNAME build-config debug 
if { [catch {configapp -app $FSBLAPPNAME define-compiler-symbols FSBL_DEBUG_INFO} var7] } {
puts " var7 = $var7/n"
} 
#configapp -app $FSBLAPPNAME -remove compiler-misc {-pg}
projects -name $FSBLAPPNAME -type app -build

closebsp $BSPNAME
closehw $HDFBASENAME
#hsi::close_hw_design [hsi::current_hw_design]
