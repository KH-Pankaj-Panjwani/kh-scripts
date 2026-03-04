#!/bin/csh -f 
## Please update below variable based on the release you want to make ###
set block_name = "bsg_rcsus_chip_guts_4_2_29_32_8_8_8_256_256_40_10_2_8_32_16_3_64_66_128_1_6_4_1_3_0_3_16_4_32_32_4_3_7_32_29_8"

set synth_sdc_path = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/VR/bsg_chipguts/pnr/RUN2/INPUTS/bsg_rcsus_chip_guts.syn.sdc"
set block_ilm_dir_path = ""
set block_lef = "/projects/ProjA1/tsmcN28_a0/work/pd_block/usr/VR/bsg_chipguts/pnr/RUN2/OUTPUT/pro_incr/bsg_rcsus_chip_guts.lef"
set block_lib_dir = ""
set block_synth_netlist = ""
set check_timing_report = ""
set check_design_report = ""
set timing_qor_report = ""
set dont_touch_path = ""
set conformal_guidance_file = ""
set lec_run_area = ""
set lec_report = ""

source /usr/drives/scratch/MaXSDR_v1_1_PD/work/WA_ANKITA/scripts/global_release_script_synth_fp.sh
