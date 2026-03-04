
#!/bin/csh -f 
## Please update below variable based on the release you want to make ###
set block_name = "bsg_rcsus_digital_top"


set sdc_signoff_path = "/projects/ProjA1/tsmcN28_a0/repositories/handoff/bsg_rcsus_digital_top_rc0.v1p1.2022_06_30_06_16/tcl/080222/constraints.flat.sdc"
set netlist_path = "/rscratch/ProjA1/tsmcN28_a0/work/pd_top/usr/jayakumar/pnr/14Jul_1/OUTPUT/top.nopg.signoff_14Jul_1_PV70.v"
set sdf_run_dir_path = "/usr/drives/scratch/MaXSDR_v1_1_PD/work/WA_ANKITA/STA/digital_top/work/12Aug_CCS_AOCV_gutsECO/SDF"
set pv_ir_release_dir_path = "/rscratch/ProjA1_dig/work/RELEASE_AREA/bsg_rcsus_digital_top/08-August-22_0400/PV_IR"
 
source /usr/drives/scratch/MaXSDR_v1_1_PD/work/WA_ANKITA/scripts/global_sdf_release_script.sh
