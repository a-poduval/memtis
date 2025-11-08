#!/bin/bash

TARGET=$1

cat /sys/fs/cgroup/htmm/memory.htmm_thresholds | awk '{print $1}' | tr '\n' ',' | sed 's/,$/\n/' >> ${TARGET}/htmm_threshold_data.csv
cat /sys/fs/cgroup/htmm/memory.hotness_stat | awk '{print $1","$3","$5}' >> ${TARGET}/hot_page_counts.csv
while :
do
    cat /sys/fs/cgroup/htmm/memory.stat | grep -e anon_thp -e anon >> ${TARGET}/memory_stat.txt
    cat /sys/fs/cgroup/htmm/memory.hotness_stat >> ${TARGET}/hotness_stat.txt
    cat /proc/vmstat | grep pgmigrate_su >> ${TARGET}/pgmig.txt
    numastat -m | grep "MemUsed\|MemFree\|HugePages" >> ${TARGET}/numastat.txt
    echo end >> ${TARGET}/numastat.txt
    cat /sys/fs/cgroup/htmm/memory.htmm_thresholds | awk '{print $2}' | tr '\n' ',' | sed 's/,$/\n/' >> ${TARGET}/htmm_threshold_data.csv
    cat /sys/fs/cgroup/htmm/memory.hotness_stat | awk '{print $2","$4","$6}' >> ${TARGET}/hot_page_counts.csv
    sleep 1
done
