#/usr/bin/env bash
set -x
time sync
dd if=/dev/zero of=/data/test bs=4096 count=$(numfmt --from=auto --to-unit=4096 10G) conv=fsync
time sync
dd if=/dev/zero of=/data/storage/test bs=4096 count=$(numfmt --from=auto --to-unit=4096 10G) conv=fsync
time sync
ls -lah /data
ls -lah /data/storage
rm /data/test
rm /data/storage/test
sleep 100000000
