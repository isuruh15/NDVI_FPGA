set_property SRC_FILE_INFO {cfile:f:/UOM/Semester7/FYP/NDVI_Camera/PickTea/NDVI_Image_1.2/NDVI_Image_1.2.srcs/sources_1/ip/clk_wiz_base/clk_wiz_base.xdc rfile:../../../NDVI_Image_1.2.srcs/sources_1/ip/clk_wiz_base/clk_wiz_base.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
