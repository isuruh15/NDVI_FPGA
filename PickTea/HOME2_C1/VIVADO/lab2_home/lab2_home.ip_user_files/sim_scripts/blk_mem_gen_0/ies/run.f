-makelib ies_lib/xil_defaultlib -sv \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/Software/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_3 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../lab2_home.srcs/sources_1/ip/blk_mem_gen_0/sim/blk_mem_gen_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

