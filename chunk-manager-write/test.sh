#/usr/bin/env bash
#dd if=/dev/zero of=/storage/test bs=10240 count=102400
ozone freon --verbose cmdw -n100 -s 4096000 -c 16 -t16 -l FILE_PER_BLOCK
date
time sync
date
echo "Hostname: $(hostname)"
echo "TEST HAS BEEN FINISHED"
sleep 100000
