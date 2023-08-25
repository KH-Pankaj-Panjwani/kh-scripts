

set dir = "/design05/mmic1/RAA270205/RAA270205_WS1/Digital"
echo $dir
find $dir -type f -size +1G -exec ls -lh {} \; | awk '{ print $3","$6" "$7","$5","$9 }' > ./large_files/$dir:t.csv

## New Code 25-Aug-23
## UserWise Split available in CSV as first few rows

#!/bin/csh -f
set dir = "/design03/radar_mmicp1"
set last_dir = $dir:t
set dt = `date +%d_%m_%y`
set output_dir = "/design03/radar_mmicp1/digital/backend/ster_flow_ver3/user/pankaj/large_files/"
##mkdir large_files
echo $dir
set output_file = "$output_dir/${dt}_${last_dir}.csv"
find $dir -type f -size +500M -exec ls -l {} \; | awk '{ print $3","$6" "$7","$5","$9 }' > $output_file

## Get Specific User disk space usage

set all_users = `awk -F "," '{print $1}' $output_file | sort -u`
        echo "UserName,Disk Space (GB)" > $dt_${last_dir}_userSplit.csv
foreach u ($all_users) 
        grep $u $output_file > $output_dir/$u.rpt
        set user_disk_usage = `awk -F "," '{sum += $3;} END {print sum/1000000}'`
        echo "$u,$user_disk_usage" >> $dt_${last_dir}_userSplit.csv
        rm -rf $output_dir/$u.rpt
end

echo "" >> $dt_${last_dir}_userSplit.csv
echo "" >> $dt_${last_dir}_userSplit.csv
echo "" >> $dt_${last_dir}_userSplit.csv
echo "UserName,Last Modified,FileSize(Byte),FileName" >> $dt_${last_dir}_userSplit.csv
 
## Add the details for People to check each file size
cat $output_file >> $dt_${last_dir}_userSplit.csv
rm -rf $output_file
