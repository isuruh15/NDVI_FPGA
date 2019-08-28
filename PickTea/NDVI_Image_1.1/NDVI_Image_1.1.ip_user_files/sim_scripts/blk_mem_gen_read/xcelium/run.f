-makelib xcelium_lib/xil_defaultlib -sv \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_3 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../../NDVI_test/NDVI_test.srcs/sources_1/ip/blk_mem_gen_read/sim/blk_mem_gen_read.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

