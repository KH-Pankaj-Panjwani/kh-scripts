#!/bin/csh -f


set project_name =  ("/home/dnpc_seaeagle2_2/workarea/" "/home/dnpc_seaeagle2_3/workarea/" "/home/dnpc_seaeagle2_4/workarea/" "/home/dnpc_seaeagle2_5/workarea/" "/home/dnpc_seaeagle2_6/workarea/" "/home/dnpc_seaeagle2_7/workarea/")
##set project_alloc = ("4000GB")
set DATA_area = "/home/dnpc_seaeagle2_2/workarea/ankita/Disk_data"
set i=1 
foreach project ( $project_name)
	set total=0
	set simple_name = `echo $project | sed 's?/?_?g'`
	set project_alloc = `df -h $project | tail -1 | awk '{printf $2}'`
	set usage = `df -h $project | tail -1 | awk '{printf $5}' | cut -d'%' -f1 `
	printf "" > $DATA_area/$simple_name.disk.temp
	echo "##########################################" > $DATA_area/disk.mail
	printf "   Project : $project\n" >> $DATA_area/disk.mail
	echo "##########################################" >> $DATA_area/disk.mail
	printf " Today     Yesterday        partition\n" >> $DATA_area/disk.mail
	## PP ## echo "##########################################"
	## PP ## printf "   Project : $project\n"
	## PP ## echo "##########################################"
	## PP ## printf " Today     Yesterday        partition\n" 
	
	foreach partition (`ls $project`)
		## echo $partition
		set earlierDu = `grep "$partition"$ $DATA_area/$simple_name.disk | awk '{print $1}'`
		# echo $earlierDu
		set space=`du -sk $project/$partition | awk '{print $1}'`
		# echo $space
	## PP ##	printf "%7.2f %7.2f %20s\n"  `echo "$space / 1000000" | bc -l` $earlierDu $partition
		printf "%7.2f %7.2f %20s\n"  `echo "$space / 1000000" | bc -l` $earlierDu $partition >>  $DATA_area/disk.mail
		printf "%7.2f %20s\n"  `echo "$space / 1000000" | bc -l` $partition >> $DATA_area/$simple_name.disk.temp
		set total=`expr $total + $space`
	end
	
	
	set earlierDu = `grep -w subTotal $DATA_area/$simple_name.disk | awk '{print $1}'`
	## PP ## echo "   ---------"
	echo "   ---------" >> $DATA_area/disk.mail
	## PP ## printf "%7.2f %7.2f %15s\n" `echo "$total / 1000000" | bc -l` $earlierDu subTotal 
	printf "%7.2f %7.2f %15s\n" `echo "$total / 1000000" | bc -l` $earlierDu subTotal >>  $DATA_area/disk.mail
	printf "%5.2f  %15s\n" `echo "$total / 1000000" | bc -l` subTotal >> $DATA_area/$simple_name.disk.temp
	## PP ## echo "   ---------" 
	## PP ## echo "   ---------" >> $DATA_area/disk.mail
	## PP ## set partition = "libraries"
	## PP ## set earlierDu = `grep -w $partition $DATA_area/$simple_name.disk | awk '{print $1}'`
	## PP ## set space=`du -sk /home/$project/$partition | awk '{print $1}'`
	## PP ## printf "%7.2f %7.2f %20s\n"  `echo "$space / 1000000" | bc -l` $earlierDu $partition
	## PP ## printf "%7.2f %7.2f %20s\n"  `echo "$space / 1000000" | bc -l` $earlierDu $partition >>  $DATA_area/disk.mail
	## PP ## printf "%5.2f %20s\n"  `echo "$space / 1000000" | bc -l` $partition >> $DATA_area/$simple_name.disk.temp
	## PP ## set total=`expr $total + $space`
	## PP ## echo "   ---------"
	## PP ## echo "   ---------" >> $DATA_area/disk.mail
	set earlierDu = `grep -w Total $DATA_area/$simple_name.disk | awk '{print $1}'`
	## PP ## printf "%7.2f  %7.2f %15s (Allocated : $project_alloc)\n" `echo "$total / 1000000" | bc -l` $earlierDu Total  
	printf "%7.2f  %7.2f %15s (Allocated : $project_alloc)\n" `echo "$total / 1000000" | bc -l` $earlierDu Total >>  $DATA_area/disk.mail
	printf "%5.2f  %15s\n" `echo "$total / 1000000" | bc -l` Total >> $DATA_area/$simple_name.disk.temp
	
	
	mv $DATA_area/$simple_name.disk.temp $DATA_area/$simple_name.disk
	
	mailx -s "$usage % : $project Disk Space" pankaj.panjwani_1@nxp.com se_revb_pd@msteams.nxp.com < $DATA_area/disk.mail 
	## mailx -s "$usage % : $project Disk Space" pankaj.panjwani_1@nxp.com < $DATA_area/disk.mail 
	set i=`expr $i + 1`
end

