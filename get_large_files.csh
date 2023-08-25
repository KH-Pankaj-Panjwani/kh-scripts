

set dir = "/design05/mmic1/RAA270205/RAA270205_WS1/Digital"
echo $dir
find $dir -type f -size +1G -exec ls -lh {} \; | awk '{ print $3","$6" "$7","$5","$9 }' > ./large_files/$dir:t.csv

#!/bin/csh -f
set dir = "/design03/radar_mmicp1"
set last_dir = $dir:t
set dt = `date +%d_%m_%y`
set output_dir = "/design03/radar_mmicp1/digital/backend/ster_flow_ver3/user/pankaj/large_files/"
##mkdir large_files
echo $dir
set output_file = "$output_dir/${dt}_${last_dir}.csv"
find $dir -type f -size +500M -mtime +60 -exec ls -l --time-style=long-iso {} \; | awk '{ print $3","$6" "$7","$5","$9 }' > $output_file

## Get Specific User disk space usage

echo "" > $output_dir/${dt}_${last_dir}_tmp.csv
set all_users = `awk -F "," '{print $1}' $output_file | sort -u`
foreach u ($all_users)
        echo $u
        grep $u $output_file > $output_dir/$u.rpt
        set user_disk_usage = `awk -F "," '{sum += $3;} END {print sum/1000000000}' $output_dir/$u.rpt`
        echo "$u,$user_disk_usage" >> $output_dir/${dt}_${last_dir}_tmp.csv
end
echo "Disk Space consumed by Files bigger than 500MB AND 2 months old" > $output_dir/${dt}_${last_dir}_userSplit.csv
echo "UserName,Disk Space (GB)" >> $output_dir/${dt}_${last_dir}_userSplit.csv
sort -t ',' -nr -k2 $output_dir/${dt}_${last_dir}_tmp.csv >> $output_dir/${dt}_${last_dir}_userSplit.csv
rm -rf $output_dir/${dt}_${last_dir}_tmp.csv
rm -rf $output_dir/*.rpt

echo "" >> $output_dir/${dt}_${last_dir}_userSplit.csv
echo "" >> $output_dir/${dt}_${last_dir}_userSplit.csv
echo "" >> $output_dir/${dt}_${last_dir}_userSplit.csv
echo "UserName,Last Modified,FileSize(Byte),FileName" >> $output_dir/${dt}_${last_dir}_userSplit.csv

## Add the details for People to check each file size
cat $output_file >> $output_dir/${dt}_${last_dir}_userSplit.csv
rm -rf $output_file
