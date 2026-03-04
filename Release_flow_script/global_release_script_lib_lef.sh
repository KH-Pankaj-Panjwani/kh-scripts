#!/bin/csh -f 
## Central Release area
set central_release_dir = "/usr/drives/scratch/MaXSDR_v1_1_PD/work/RELEASE_AREA"

## Stage
set stage = "LIB_LEF"

## Add all files and directories which are supposed to be released 
set all_rel_files = "\
$block_lib_dir \
$block_lef \
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
	mkdir -p $rel_dir/{LIB,LEF}
	chmod -R 755 $rel_dir/{LIB,LEF}
	echo "INFO : `tree $rel_dir`"
	echo "INFO : Please answer below questions for the Release Notes"
	echo ""
	echo "Release Directory : " > $rel_dir/RELEASE_NOTE
	## Mandatory inputs
	foreach checks (\
		"Release Comments : " \
		"Version of write_data_global_script : " \
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
	echo "INFO : Copying LEF ... "
	cp -rf $block_lef $rel_dir/LEF/$block_name.lef
	echo "INFO : Files copied ... "
	
	## mailx -s "$block :PDV Release : $d" $USER pankaj.panjwani@keenheads.com harshit.tiwari@keenheads.com < $rel_dir/RELEASE_NOTE
	cat $rel_dir/RELEASE_NOTE
	tree -L 3 $rel_dir >>  $rel_dir/RELEASE_NOTE
	
	echo ""
	echo "INFO : Exiting ...."
else
	echo 'CAUTION : Exiting without creating release as your response is not "y"'
endif
