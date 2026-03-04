#!/bin/csh -f 
## Central Release area
set central_release_dir = "/usr/drives/scratch/MaXSDR_v1_1_PD/work/RELEASE_AREA"

## Stage
set stage = "SDF"

## Add all files and directories which are supposed to be released 
set all_rel_files = "\
$sdc_signoff_path \
$netlist_path \
$sdf_run_dir_path \
$pv_ir_release_dir_path \
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
	mkdir -p $rel_dir/{SDC,NETLIST}
	echo "INFO : `tree $rel_dir`"
	echo "INFO : Please answer below questions for the Release Notes"
	echo ""
	echo "Release Directory : " > $rel_dir/RELEASE_NOTE
	## Mandatory inputs
	foreach checks (\
		"Release Comments : " \
		"SDF Timing clean for setup, if not then on which frequency it will work (Yes/No) : " \
		"SDF Timing clean for hold (Yes/No) : " \
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
	
	echo "INFO : Copying Netlist ... "
	cp -rf $netlist_path $rel_dir/NETLIST/$block_name.v
	echo "INFO : Copying SDC  ... "
	cp -rf $sdc_signoff_path $rel_dir/SDC/
	echo "INFO : Copying SDF ... "
	cp -rf $sdf_run_dir_path/SDF_* $rel_dir/
	find $rel_dir/SDF_* -maxdepth 1 -type f -delete
	find $rel_dir/SDF_*/reports_read_sdf -maxdepth 1 -type f -delete
	echo "Linking PV_IR release dir path"
	ln -s $pv_ir_release_dir_path $rel_dir/
	echo "INFO : Files copied ... "
	
	## mailx -s "$block :PDV Release : $d" $USER pankaj.panjwani@keenheads.com harshit.tiwari@keenheads.com < $rel_dir/RELEASE_NOTE
	cat $rel_dir/RELEASE_NOTE
	tree -L 3 $rel_dir >>  $rel_dir/RELEASE_NOTE
	
	echo ""
	echo "INFO : Exiting ...."
else
	echo 'CAUTION : Exiting without creating release as your response is not "y"'
endif
