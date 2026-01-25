onerror {resume}
quietly virtual signal -install /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6 { /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/data_o[7:0]} DataStream
quietly virtual signal -install /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6 {/FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/data_o[8]  } SOF
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider DISP_CTRL
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/ENABLE_I
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/RESETN_I
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/SYS_CLK_I
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/DATA_TRIGGER_O
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/FRAME_END_O
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/H_RES_O
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/H_SYNC_O
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/V_ACTIVE_O
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/V_RES_O
add wave -noupdate /FrameRD_TB/FrameRD_0/Display_Controller_C0_0/V_SYNC_O
add wave -noupdate -divider {DDR CONTROLLER}
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/reset_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/sys_clk_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/c_LINE_GAP
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/burst_len_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/prefetch_line_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/ddr_data_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/ddr_data_valid_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/read_ackn_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/read_done_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/sof_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/frame_start_addr_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/h_pan_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/v_pan_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/read_req_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/burst_hcount_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/ddr_data_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/read_start_addr_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_state
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_hcount
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_count_max
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_read_req
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_read_start_addr
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_pan_h
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_pan_h_dly
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_pan_v
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/s_pan_v_dly
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/frame_start_addr_temp
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/dummy1
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/wddr_data
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/rSOF_FLAG
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/rBurstCounter
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/rLineCounter
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DDR_read_controller_0/rOUTOFSYNC
add wave -noupdate -divider DDR_NATIVE
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/reset_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/sys_clk_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/ddr_clk_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/line_gap_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/horz_resl_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/sof_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/frame_start_addr_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/h_pan_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/v_pan_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/read_ackn_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/read_done_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/ddr_data_valid_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wdata_i
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/read_start_addr_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/read_req_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/burst_size_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/TLASTo
add wave -noupdate -divider Axis
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/rStreamCnt
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/DataStream
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/SOF
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/rTLASTo
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/data_valid_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wdata_ready_i
add wave -noupdate -divider {New Divider}
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/data_o
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/brust_hcount_o_net_0
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/read_req_o_net_0
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/read_start_addr_o_net_0
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/AND2_0_Y
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wWFifoCnt
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wRFifoCnt
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoWen
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoRen
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoDataValid
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wDataValid
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoFull
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoEmpty
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoAlmostEmpty
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoWArstn
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoRArstn
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wFifoDataOutput
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/rWAlmostEmpty
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wddr_data_int
add wave -noupdate /FrameRD_TB/FrameRD_0/DDR_Read_0/genblk1/DDR_Read_Native_6/wNumBursts
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2333421 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 182
configure wave -valuecolwidth 102
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1617790178 ps}
