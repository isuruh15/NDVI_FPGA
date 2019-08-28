-makelib ies_lib/xil_defaultlib -sv \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../NDVI_Image_1.2.srcs/sources_1/ip/clk_wiz_base/clk_wiz_base_clk_wiz.v" \
  "../../../../NDVI_Image_1.2.srcs/sources_1/ip/clk_wiz_base/clk_wiz_base.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

