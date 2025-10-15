#!/bin/bash

TARGET=$1

while :
do
    cat /sys/fs/cgroup/htmm/memory.stat | grep -e anon_thp -e anon >> ${TARGET}/memory_stat.txt
    cat /sys/fs/cgroup/htmm/memory.hotness_stat >> ${TARGET}/hotness_stat.txt
    cat /proc/vmstat | grep pgmigrate_su >> ${TARGET}/pgmig.txt
    numastat -m | grep "MemUsed\|MemFree\|HugePages" >> ${TARGET}/numastat.txt
    echo end >> ${TARGET}/numastat.txt
    sleep 1
done
