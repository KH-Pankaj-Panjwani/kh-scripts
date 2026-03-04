#!/bin/csh -f 
## Central Release area
set central_release_dir = "/rscratch/ProjA1_dig/work/RELEASE_AREA"

## Stage
set stage = "SYNTH_FP"

## Add all files and directories which are supposed to be released 
set all_rel_files = "\
$synth_sdc_path \
$block_ilm_dir_path \
$block_lef \
$block_lib_dir \
$block_synth_netlist \
$check_timing_report \
$check_design_report \
$timing_qor_report \
$dont_touch_path \
$conformal_guidance_file \
$lec_run_area \
$lec_report \
" 

## get date in format 14-March-22 to create a release directory
set d = `date +%d-%B-%y`
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
	mkdir -p $rel_dir/{SDC,ILM,LEF,LIB,NETLIST,REPORTS,LEC}
	echo "INFO : `tree $rel_dir`"
	echo "INFO : Please answer below questions for the Release Notes"
	echo ""
	echo "Release Directory : " > $rel_dir/RELEASE_NOTE
	## Mandatory inputs
	foreach checks (\
		"Release Comments : " \
		"Any new Check timing issue compared to prev release (Yes/No) : " \
		"Any new Check design issue compared to prev release (Yes/No) : " \
		"Block ILM & LIBs are generated with same Database (Yes/No) : " \
		"Block lef & LIbs are aligned with same DB (Yes/No) : " \
		"LEC is clean with RTL vs Map (Yes/No) : " \
		"LEC is clean with Map vs Final synth (Yes/No) : " \
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
	
	echo "INFO : Copying SDC ... "
	cp -rf $synth_sdc_path $rel_dir/SDC/
	echo "INFO : Copying ILM ... "
	cp -rf $block_ilm_dir_path $rel_dir/ILM/
	echo "INFO : Copying LEF ... "
	cp -rf $block_lef $rel_dir/LEF/$block_name.lef
	echo "INFO : Copying LIB ... "
	cp -rf $block_lib_dir/*.lib $rel_dir/LIB/
	echo "INFO : Copying Netlist ... "
	cp -rf $block_synth_netlist $rel_dir/NETLIST/$block_name.synth.v
	echo "INFO : Copying Synthesis reports ... "
	cp -rf $check_timing_report $rel_dir/REPORTS/
	cp -rf $check_design_report $rel_dir/REPORTS/
	cp -rf $timing_qor_report $rel_dir/REPORTS/
	cp -rf $dont_touch_path $rel_dir/REPORTS/
		echo "INFO : Copying LEC data ... "
	cp -rf $conformal_guidance_file $rel_dir/LEC/
	cp -rf $lec_report $rel_dir/LEC/
	echo "INFO : Files copied ... "
	
	## mailx -s "$block :PDV Release : $d" $USER pankaj.panjwani@keenheads.com < $rel_dir/RELEASE_NOTE
	cat $rel_dir/RELEASE_NOTE
	tree -L 3 $rel_dir >>  $rel_dir/RELEASE_NOTE
	
	echo ""
	echo "INFO : Exiting ...."
else
	echo 'CAUTION : Exiting without creating release as your response is not "y"'
endif
