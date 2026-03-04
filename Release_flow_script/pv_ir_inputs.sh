
#!/bin/csh -f 
## Please update below variable based on the release you want to make ###
set block_name = "bsg_rcsus_chip_guts_4_2_29_32_8_8_8_256_256_40_10_2_8_32_16_3_64_66_128_1_6_4_1_3_0_3_16_4_32_32_4_3_7_32_29_8"


set block_lib_dir = ""
set sta_sdc_path = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/INPUTS/bsg_rcsus_chip_guts.syn.sdc"
set sta_sdf_path = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/INPUTS/bsg_rcsus_chip_guts.syn.sdc"
set sta_view_defn = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/view_definition/viewDefinition.tcl"
set block_lef = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr/bsg_rcsus_chip_guts.lef"
set block_def = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr2_hold/PV0/bsg_rcsus_chip_guts_PV0.def"
set block_pnr_db = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr2_hold/PV0/pro_incr2_hold_filler_decap.enc.dat"
set block_pnr_netlist = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr2_hold/PV0/bsg_rcsus_chip_guts_nopg.signoff_PV0.v"
set block_pnr_lvs_netlist = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr2_hold/PV0/bsg_rcsus_chip_guts_pg.signoff_PV0.v"
set block_spef_dir = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr/bsg_rcsus_chip_guts.lef"
set block_gds = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr2_hold/PV0/bsg_rcsus_chip_guts.merged.gds" 
set block_hollow_gds = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/ANKITA/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr2_hold/PV0/bsg_rcsus_chip_guts.hollow.gds" 
set all_mem_list = ""
set block_pnr_pg_netlist = ""
## AA ## for all_mem_list, when you dump write data from innovus, it will dump block_name_mem.rpt in release dir, give that path here.

## AA ## source /usr/drives/scratch/MaXSDR_v1_1_PD/work/WA_ANKITA/scripts/gds_merge_list.txt
source /usr/drives/scratch/MaXSDR_v1_1_PD/work/WA_ANKITA/scripts/gds_merge_list_newMem.txt
source /usr/drives/scratch/MaXSDR_v1_1_PD/work/WA_ANKITA/scripts/global_release_script_pv_ir.sh
