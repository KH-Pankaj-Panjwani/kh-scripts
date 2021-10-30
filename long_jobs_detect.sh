#!/bin/bash
##set -xv
users="nxf80064 nxf80067"
mail_id="pankaj.panjwani_1@nxp.com "
now=`date +'%s'`
long_jobs=/tmp/${USER}_long_jobs
echo "`date ` " > $long_jobs 
echo "################################" >> $long_jobs
timestamp() { 
    date '+%s%N' --date="$1"
}
for u in $users ; do
	echo "user : $u" >> $long_jobs
	## get all jobs in a temp file
	jobs=`bjobs -noheader -u $u -o "jobid:10" `
	## echo $jobs
	for j in $jobs ; do
	## 	echo "JobID : $j"
		t=`bjobs -noheader -o start_time $j`
		j_start=`date --date "$t" +"%s"`
	## 	echo "Job Start = $j_start"
	## 	echo "Now 	= $now"
		#echo $(( $(timestamp "$etime") - $(timestamp "$stime") ))
		##echo $(( $(timestamp "$now") - $(timestamp "$j_start") ))
		h_age=$(((($now - $j_start)) / 3600 ))
		h_age="${h_age//[$'\t\r\n ']}"
		#h_age=`expr  $now - $j_start / 3600` 
	## 	echo $h_age	
		if  [ "$h_age" -gt "24" ]  ; then 
			bjobs $j >> $long_jobs
		fi
	done
echo "################################" >> $long_jobs
done
mailx -s "Long Jobs > 2 days" $mail_id < $long_jobs 
