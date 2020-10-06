#!/usr/bin/env bash

set -ex

export HADOOP_OPTS=-agentpath:/opt/java-async-profiler/build/libasyncProfiler.so=start,file=/tmp/profile.svg,event=cpu
#export HADOOP_OPTS=-javaagent:/opt/byteman/lib/byteman.jar=script:/opt/btm/hcfs-write.btm

ozone freon dfsg -s1024000 -n10000 -t10

sleep infinity
