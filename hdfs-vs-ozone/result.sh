#!/usr/bin/env bash

head -n1 $1

grep "write.allTime" $1
grep "close.allTime" $1
