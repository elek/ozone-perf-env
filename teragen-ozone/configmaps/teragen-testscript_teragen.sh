#!/usr/bin/env bash

set -x

ROWS=$(numfmt --from=auto --to-unit=100 ${TEST_SIZE:-100G})
MR_EXAMPLES_JAR=/opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar

OUTPUT_DIR=teragen-$(shuf -i 1000-2000 -n 1)

OUTPUT_DIR=o3fs://bucket1.vol1.ozone-om-0.ozone-om/$OUTPUT_DIR

time yarn jar $MR_EXAMPLES_JAR teragen \
-Dmapred.map.tasks=${TEST_MAPPERS:-2} \
-Dmapreduce.map.log.level=INFO \
-Dmapreduce.reduce.log.level=INFO \
-Dyarn.app.mapreduce.am.log.level=INFO \
$ROWS $OUTPUT_DIR

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
#-Dio.file.buffer.size=131072 \

echo "Test is Done"
