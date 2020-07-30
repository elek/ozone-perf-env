#/usr/bin/env bash

rm -rf /data/storage/hdds
time sync
START_TIME=$(date +%s.%N)
ozone freon --verbose cmdw -n1000000 -s$(numfmt --from=iec 1K) -t1 -l FILE_PER_BLOCK
time sync
END_TIME=$(date +%s.%N)
echo "Total time: $(echo $END_TIME $START_TIME | awk '{print $1 - $2}')"
echo "Hostname: $(hostname)"
echo "Test is Done"
sleep 100000
