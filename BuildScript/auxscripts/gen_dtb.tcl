if { $::argc == 4 } {
    set i 1
    foreach arg $::argv {
    	puts "argument $i is $arg"
    	if {$i==1} {
    	set HDF $arg
    	} elseif {$i==2} {
    	set ZARCH $arg
    	} elseif {$i==3} {
	set DTREPO $arg
	} elseif {$i==4} {
	set WS $arg
	}
	incr i
    }
} else {
puts "Help Usage argv1 hdf_file argv2 zynq_type argv3 dtrepo argv4 ws_name "
exit 
}

setws -switch $WS
if { [catch {getprojects -type hw} var1]} {
puts "var1 = $var1"
} else {
puts "Listing hw project available in the ws $WS"
}
if { [catch {getprojects -type bsp} var2]} {
puts "var2 = $var2"
} else {
puts "Listing bsp project available in the ws $WS"
}
if { [catch {getprojects -type app} var3]} {
puts "var3 = $var3"
} else {
puts "Listing sw project available in the ws $WS"
}

set HDFBASENAME [file rootname [file tail $HDF]]
#set BSPNAME ${HDFBASENAME}BSP
set DTNAME ${HDFBASENAME}DT
#puts " HDFBASENAME=$HDFBASENAME"
if { [catch {openhw $HDFBASENAME} var4] } {
puts "var4 = $var4\n"
createhw -name $HDFBASENAME -hwspec $HDF
openhw $HDF
} else {
updatehw -hw $HDFBASENAME -newhwspec $HDF
puts "Project $HDFBASENAME already exists in $WS ...opening..."
}
if {$ZARCH=="zynq7"} {

set PROC ps7_cortexa9_0
set FSBLTEMPLATE "Zynq FSBL"
set PROCARCH 32
}

repo -set $DTREPO

if {  [catch {openbsp $DTNAME} var5] } {
puts " var5 = $var5/n"
createbsp -name $DTNAME -proc $PROC -hwproject $HDFBASENAME -os device_tree
openbsp $DTNAME
} else {
#createbsp -name $BSPNAME -proc $PROC -hwproject $HDFBASENAME -os standalone -arch $PROCARCH
puts " BSP project $DTNAME already exist ... opening "
}
projects -type bsp -name $DTNAME -clean
regenbsp -bsp $DTNAME
projects -type bsp -name $DTNAME -build 


closebsp $DTNAME
closehw $HDFBASENAME
#hsi::close_hw_design [hsi::current_hw_design]
