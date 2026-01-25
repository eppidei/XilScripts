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

vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/AXI4_M_M_IF.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/AXI4_S_IF.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_corefifo_NstagesSync.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_corefifo_grayToBinConv.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_corefifo_async.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_corefifo_resetSync.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_corefifo_sync.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_corefifo_fwft.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_corefifo_sync_scntr.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_LSRAM_top.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/axi_lbus_ram_wrapper.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/video_axi_fifo.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/ddr_rw_arbiter.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/write_mux.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/request_scheduler.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/write_demux.vhd"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/write_top.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/read_demux.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/read_mux.vhd"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/read_top.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/DDR_AXI4_ARBITER_PF_Native.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/DDR_AXI4_ARBITER_PF/2.2.0/RTL/DDR_AXI4_ARBITER_PF.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/DDR_AXI4_ARBITER_PF_C0/DDR_AXI4_ARBITER_PF_C0.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/Microchip/SolutionCore/Display_Controller/5.0.0/Encrypted/display_controller.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/Display_Controller_C0/Display_Controller_C0.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/PF_SRAM_AHBL_AXI_C0/PF_TPSRAM_AHB_AXI_0/PF_SRAM_AHBL_AXI_C0_PF_TPSRAM_AHB_AXI_0_PF_TPSRAM.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/PF_SRAM_AHBL_AXI_C0/COREAXI4SRAM_0/rtl/vlog/core/CoreAXI4SRAM_MAINCTRL_ECC.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/PF_SRAM_AHBL_AXI_C0/COREAXI4SRAM_0/rtl/vlog/core/CoreAXI4SRAM_MAINCTRL.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/PF_SRAM_AHBL_AXI_C0/COREAXI4SRAM_0/rtl/vlog/core/CoreAXI4SRAM_SLVIF.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/PF_SRAM_AHBL_AXI_C0/COREAXI4SRAM_0/rtl/vlog/core/CoreAXI4SRAM.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/PF_SRAM_AHBL_AXI_C0/PF_SRAM_AHBL_AXI_C0.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/Arbiter_Initiator_Rd_IF.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/corefifo_fwft.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/corefifo_sync_scntr.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/corefifo_sync.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/corefifo_graytobinconv.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/corefifo_nstagessync.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/corefifo_async.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/DDR_READ_ASYMM_FIFO_DDR_READ_ASYMM_FIFO_0_LSRAM_top.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/DDR_READ_ASYMM_FIFO_DDR_READ_ASYMM_FIFO_0_ram_wrapper.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/COREFIFO.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/DDR_read_controller.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/DDR_Read_Native.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/DDR_Read.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/FrameRD/FrameRD.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/CLK_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/DDR_CLK" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/PULSE_GEN_C0" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/FrameRD_TB" -sv -work presynth "${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1/CLK_GEN.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/CLK_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/DDR_CLK" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/PULSE_GEN_C0" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/FrameRD_TB" -sv -work presynth "${PROJECT_DIR}/component/work/CLK_GEN_C0/CLK_GEN_C0.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/CLK_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/DDR_CLK" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/PULSE_GEN_C0" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/FrameRD_TB" -sv -work presynth "${PROJECT_DIR}/component/work/DDR_CLK/DDR_CLK.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/CLK_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/DDR_CLK" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/PULSE_GEN_C0" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/FrameRD_TB" -sv -work presynth "${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1/PULSE_GEN.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/CLK_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/DDR_CLK" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/PULSE_GEN_C0" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/FrameRD_TB" -sv -work presynth "${PROJECT_DIR}/component/work/PULSE_GEN_C0/PULSE_GEN_C0.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/CLK_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/DDR_CLK" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/PULSE_GEN_C0" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/FrameRD_TB" -sv -work presynth "${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1/RESET_GEN.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/CLK_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/DDR_CLK" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/PULSE_GEN_C0" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/FrameRD_TB" -sv -work presynth "${PROJECT_DIR}/component/work/RESET_GEN_C0/RESET_GEN_C0.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/CLK_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/CLK_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/DDR_CLK" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/PULSE_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/PULSE_GEN_C0" "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/FrameRD_TB" -sv -work presynth "${PROJECT_DIR}/component/work/FrameRD_TB/FrameRD_TB.v"

vsim -voptargs=+acc -L PolarFire -L presynth  -t 1ps -displaymsgmode both presynth.FrameRD_TB
add log -r /*
do wave.do
run 30 ms
