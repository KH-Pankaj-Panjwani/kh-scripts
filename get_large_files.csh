

set dir = "/design05/mmic1/RAA270205/RAA270205_WS1/Digital"
echo $dir
find $dir -type f -size +1G -exec ls -lh {} \; | awk '{ print $3","$6" "$7","$5","$9 }' > ./large_files/$dir:t.csv
