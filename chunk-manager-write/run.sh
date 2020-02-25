#!/usr/bin/env bash

set -x

execute_test(){
  OUTPUT_DIR=/tmp/testresults/$1
  shift
  CMD=$@
  sed -i "s/ozone .*/$CMD/g" test.sh
  mkdir -p $OUTPUT_DIR
  REPLICAS=6

  ./deploy-test.sh

  RUNNING=true
  while [[ "$RUNNING" ]]; do
      for i in `seq 0 $((REPLICAS-1))`; do kubectl logs --tail=1 ozone-datanode-$i -c freon; done > $OUTPUT_DIR/progress.txt
    cat $OUTPUT_DIR/progress.txt
    DONE=$(cat $OUTPUT_DIR/progress.txt | grep "TEST HAS BEEN FINISHED" | wc -l)
    if [[ "$DONE" == $REPLICAS ]]; then
        break
    fi
    sleep 5
  done
  for i in `seq 0 $((REPLICAS-1))`; do kubectl logs --tail=12 ozone-datanode-$i -c freon; done > $OUTPUT_DIR/result
  cp test.sh $OUTPUT_DIR/test.sh
}

execute_test perchunk-1k   ozone freon --verbose cmdw -n1000000 -s 1024    -t16 -l FILE_PER_CHUNK
execute_test perchunk-10k  ozone freon --verbose cmdw -n100000  -s 10240   -t16 -l FILE_PER_CHUNK
execute_test perchunk-100k ozone freon --verbose cmdw -n10000   -s 102400  -t16 -l FILE_PER_CHUNK
execute_test perchunk-1M   ozone freon --verbose cmdw -n1000    -s 1024000 -t16 -l FILE_PER_CHUNK
execute_test perchunk-4M   ozone freon --verbose cmdw -n100     -s 4096000 -t16 -l FILE_PER_CHUNK


execute_test onefile-1k    ozone freon --verbose cmdw -n1000000 -s 1024    -c 16 -t16 -l FILE_PER_BLOCK
execute_test onefile-10k   ozone freon --verbose cmdw -n100000  -s 10240   -c 16 -t16 -l FILE_PER_BLOCK
execute_test onefile-100k  ozone freon --verbose cmdw -n10000   -s 102400  -c 16 -t16 -l FILE_PER_BLOCK
execute_test onefile-1M    ozone freon --verbose cmdw -n1000    -s 1024000 -c 16 -t16 -l FILE_PER_BLOCK
execute_test onefile-4M    ozone freon --verbose cmdw -n100     -s 4096000 -c 16 -t16 -l FILE_PER_BLOCK

