#!/usr/bin/env bash

set -x

ROWS=$(numfmt --from=auto --to-unit=100 ${TEST_SIZE:-10G})
MR_EXAMPLES_JAR=/opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar

for i in `seq 0 0`; do

OUTPUT_DIR=teragen-$(shuf -i 1000-2000 -n 1)

OUTPUT_DIR=hdfs://hdfs-namenode-0.hdfs-namenode:9820/$OUTPUT_DIR

time yarn jar $MR_EXAMPLES_JAR teragen \
-Dmapred.map.tasks=${TEST_MAPPERS:-2} \
-Dmapreduce.map.log.level=INFO \
-Dmapreduce.reduce.log.level=INFO \
-Dyarn.app.mapreduce.am.log.level=INFO \
$ROWS $OUTPUT_DIR

#-Dmapreduce.map.log.level=INFO \
#-Dmapreduce.reduce.log.level=INFO \
#-Dyarn.app.mapreduce.am.log.level=INFO \
#-Dmapreduce.map.cpu.vcores=1 \
#-Dmapreduce.map.java.opts=-Xmx1536m \
#-Dmapreduce.map.maxattempts=1 \
#-Dmapreduce.map.memory.mb=2048 \
#-Dmapreduce.map.output.compress=true \
#-Dmapreduce.map.output.compress.codec=org.apache.hadoop.io.compress.Lz4Codec \
#-Dmapreduce.reduce.cpu.vcores=1 \
#-Dmapreduce.reduce.java.opts=-Xmx1536m \
#-Dmapreduce.reduce.maxattempts=1 \
#-Dmapreduce.reduce.memory.mb=2048 \
#-Dyarn.app.mapreduce.am.command.opts=-Xmx768m \
#-Dyarn.app.mapreduce.am.resource.mb=1024 \
#-Dmapreduce.task.io.sort.factor=100 \
#-Dmapreduce.task.io.sort.mb=384 \
#-Dmapred.map.tasks=92 \
#-Dio.file.buffer.size=131072 \

done
echo "Test is Done"
