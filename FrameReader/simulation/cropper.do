onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/iClk
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/iRstn
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/Cropper_0/iCROP_X1
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/Cropper_0/iCROP_X2
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/Cropper_0/iCROP_Y1
add wave -noupdate -radix unsigned /FrameRD_TB/FrameRD_0/Cropper_0/iCROP_Y2
add wave -noupdate -divider SLAVE
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/s_tdata
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/s_tdata_valid
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/s_tlast
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/s_user
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/s_ready
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/ws_SOF
add wave -noupdate -divider MASTER
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/m_tdata
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/m_tdata_valid
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/m_tlast
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/m_user
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/m_ready
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/wValidCnt
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/rCOL_CNT
add wave -noupdate /FrameRD_TB/FrameRD_0/Cropper_0/rROW_CNT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1121222 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {1077626 ps} {1243957 ps}
