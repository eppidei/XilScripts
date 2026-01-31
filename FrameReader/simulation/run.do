quietly set ACTELLIBNAME PolarFire
quietly set PROJECT_DIR "C:/prj/FrameReader"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap PolarFire "C:/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/questasim/precompiled/vlog/polarfire"

vlog -sv -work presynth "${PROJECT_DIR}/hdl/DebayerGemini2.v"
vlog "+incdir+${PROJECT_DIR}/hdl" "+incdir+${PROJECT_DIR}/stimulus" -sv -work presynth "${PROJECT_DIR}/stimulus/tb_axis_bayergemini2.v"

vsim -voptargs=+acc -L PolarFire -L presynth  -t 1ps -displaymsgmode both presynth.tb_axis_bayer_gemini2
add wave -r /tb_axis_bayer_gemini2/*
add log -r /*
run 20 ms
