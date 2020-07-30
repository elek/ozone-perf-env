#/usr/bin/env bash
set -x
cd /data
time sync
fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4 --runtime=240 --group_reporting
time sync
fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=256M --numjobs=8 --runtime=240 --group_reporting
time sync
fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=128M --numjobs=16 --runtime=240 --group_reporting
time sync
fio --name=randread --ioengine=libaio --iodepth=16 --rw=randread --bs=4k --direct=0 --size=64M --numjobs=32 --runtime=240 --group_reporting
time sync
sleep 100000000
