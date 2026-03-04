#!/bin/csh -f 
## Central Release area
set central_release_dir = "/usr/drives/scratch/MaXSDR_v1_1_PD/work/RELEASE_AREA"

## Stage
set stage = "PV_IR"

## Add all files and directories which are supposed to be released 
set all_rel_files = "\
$block_lib_dir \
$sta_sdc_path \
$sta_view_defn \
$block_lef \
$block_def \
$block_pnr_netlist \
$block_pnr_lvs_netlist \
$block_spef_dir \
$block_gds \
$block_hollow_gds \
$all_mem_list \
$block_pnr_pg_netlist \
" 

## get date in format 14-March-22 to create a release directory
set d = `date +%d-%B-%y_%H%M`
set rel_dir = "$central_release_dir/$block_name/$d/$stage"

## Let user know the dates of critical files which will be released through this script
## This is a visual notification to user 

foreach rel_file (`echo $all_rel_files`) 
	echo `date -r $rel_file` : $rel_file
end


echo "QUESTION : Please check if the above timestamp for files are ok (y/n) : "
set in = "$<"
if ($in == "y") then
	echo "INFO : Release Dir will be : $rel_dir"
	echo ""
	echo "INFO : Creating directory structure . . . "
	mkdir -p $rel_dir/{LIB,SDC,GDS,DEF,LEF,PNR,SPEF,NETLIST}
	chmod -R 755 $rel_dir/{LIB,SDC,GDS,DEF,LEF,PNR,SPEF,NETLIST}
	echo "INFO : `tree $rel_dir`"
	echo "INFO : Please answer below questions for the Release Notes"
	echo ""
	echo "Release Directory : " > $rel_dir/RELEASE_NOTE
	## Mandatory inputs
	foreach checks (\
		"Release Comments : " \
		"Version of write_data_global_script : " \
		"Is it release for IR: " \
		"Is it release for EM: " \
		"Is it release for STA: " \
		"PnR Shorts Clean (Yes/No) : " \
		"LVS clean in PnR (Yes/No) : " \
		"DRC Count in PnR : " \
		"Is LEC clean with this netlist: " \
		"Dummy Metal tiling Done (Yes/No) : " \
		"FILL & DECAP Insertion Done (Yes/No) : " \
		"Is Hold ARC coming in ETMs after reset_path_exception (Yes/No) : " \
		)
		echo -n $checks" " >> $rel_dir/RELEASE_NOTE
		echo -n $checks" "
		set in = "$<"
		echo  "$in"  >> $rel_dir/RELEASE_NOTE
	end
		## Optional Inputs
	## echo  "#######################################"
	## echo  "#########  OTHER INFORMATION #########"
	## echo  "#######################################" >> $rel_dir/RELEASE_NOTE
	## echo  "#########  OTHER INFORMATION #########" >> $rel_dir/RELEASE_NOTE
	echo "INFO : Copying Release data . . . . "
	
	## Copying Relevant files to the release area
	echo "INFO : Copying LIB ... "
	cp -rf $block_lib_dir/*.lib $rel_dir/LIB/
	echo "INFO : Copying Netlist ... "
	cp -rf $block_pnr_netlist $rel_dir/NETLIST/$block_name.v
	cp -rf $block_pnr_pg_netlist $rel_dir/NETLIST/$block_name.pg.v
	cp -rf $block_pnr_lvs_netlist $rel_dir/NETLIST/$block_name.lvs.v
	echo "INFO : Copying LEF and DEF ... "
	cp -rf $block_lef $rel_dir/LEF/$block_name.lef
	cp -rf $block_def $rel_dir/DEF/$block_name.def
	echo "INFO : Copying SDC and viewDefn ... "
	## AA ## cp -rf $sta_sdc_path $rel_dir/SDC/$block_name.sdc
	cp -rf $sta_sdc_path $rel_dir/SDC/
	cp -rf $sta_view_defn $rel_dir/SDC/
	echo "INFO : Copying PnR DB, GDS and SPEF ... "
	cp -rf $block_pnr_db $rel_dir/PNR/
	cp -rf $block_spef_dir/*.spef.gz $rel_dir/SPEF/
	cp -rf $block_gds $rel_dir/GDS/$block_name.gds
	cp -rf $block_hollow_gds $rel_dir/GDS/$block_name.hollow.gds
	
	cp -rf $all_mem_list $rel_dir/

	echo "INFO : Files copied ... "
	
	## mailx -s "$block :PDV Release : $d" $USER pankaj.panjwani@keenheads.com harshit.tiwari@keenheads.com < $rel_dir/RELEASE_NOTE
	cat $rel_dir/RELEASE_NOTE
	tree -L 3 $rel_dir >>  $rel_dir/RELEASE_NOTE
	
	echo ""
	echo "INFO : Exiting ...."
else
	echo 'CAUTION : Exiting without creating release as your response is not "y"'
endif
