#!/bin/bash

# HTMM Epoch Statistics Collection Script
# Usage: ./collect_epoch_stats.sh <output_dir> [interval_seconds]
#
# This script collects HTMM statistics periodically and outputs to CSV format.
# It monitors promotions, demotions, hotness histograms, and access patterns.
#
# Arguments:
#   output_dir       : Directory where CSV files will be written
#   interval_seconds : Sampling interval in seconds (default: 1)

TARGET=$1
INTERVAL=${2:-1}

# Initialize CSV file with headers
CSV_FILE="${TARGET}/htmm_epoch_stats.csv"
echo "timestamp,promotions,demotions,sampled,missed_dram,missed_nvm,hot_pages,warm_pages,cold_pages,active_threshold,warm_threshold,bp_active_threshold,split_threshold,cooling_clock" > ${CSV_FILE}

# Function to extract value from vmstat
get_vmstat() {
    grep "^$1 " /proc/vmstat | awk '{print $2}'
}

# Function to extract hotness stats
get_hotness_stats() {
    local file="${TARGET}/hotness_stat_tmp.txt"
    cat /sys/fs/cgroup/htmm/memory.hotness_stat > ${file} 2>/dev/null
    tail -n 1 ${file} | awk '{print $2","$4","$6}'
}

# Function to extract threshold values
get_thresholds() {
    local file="${TARGET}/htmm_thresholds_tmp.txt"
    cat /sys/fs/cgroup/htmm/memory.htmm_thresholds > ${file} 2>/dev/null

    local active=$(grep "^active_threshold" ${file} | awk '{print $2}')
    local warm=$(grep "^warm_threshold" ${file} | awk '{print $2}')
    local bp_active=$(grep "^bp_active_threshold" ${file} | awk '{print $2}')
    local split=$(grep "^split_threshold" ${file} | awk '{print $2}')
    local cooling=$(grep "^cooling_clock" ${file} | awk '{print $2}')

    echo "${active},${warm},${bp_active},${split},${cooling}"
}

# Main monitoring loop
while :
do
    TIMESTAMP=$(date +%s.%N)

    # Collect VM stats
    PROMOTED=$(get_vmstat "htmm_nr_promoted")
    DEMOTED=$(get_vmstat "htmm_nr_demoted")
    SAMPLED=$(get_vmstat "htmm_nr_sampled")
    MISSED_DRAM=$(get_vmstat "htmm_missed_dramread")
    MISSED_NVM=$(get_vmstat "htmm_missed_nvmread")

    # Collect hotness stats (hot, warm, cold page counts)
    HOTNESS=$(get_hotness_stats)

    # Collect threshold values
    THRESHOLDS=$(get_thresholds)

    # Write to CSV
    echo "${TIMESTAMP},${PROMOTED},${DEMOTED},${SAMPLED},${MISSED_DRAM},${MISSED_NVM},${HOTNESS},${THRESHOLDS}" >> ${CSV_FILE}

    sleep ${INTERVAL}
done
