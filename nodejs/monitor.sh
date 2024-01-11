#!/bin/bash

# Defining the process to monitor
LANGUAGE="nodejs"
PROCESS_PID=56750

# Check if the process is running
if [ -z "$PROCESS_PID" ]; then
    echo "No process starting with '$PROCESS_PREFIX' found."
    exit 1
fi

# Preparing the CSV file
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
CSV_FILE="process_monitor_${LANGUAGE}_${TIMESTAMP}.csv"
echo "Timestamp;CPU Usage (%);Mem Usage (MiB);Mem Usage (KiB);Virtual Mem (MiB);Virtual Mem (KiB);Threads;Page Faults" > $CSV_FILE
SLEEP_INTERVAL=1

# Function to calculate total system CPU times
get_total_cpu_time() {
    cpu_times=$(cat /proc/stat | grep '^cpu ' | awk '{for(i=2;i<=NF;i++) sum+=$i} END {print sum}')
    echo $cpu_times
}

# Initial total CPU time
PREV_TOTAL_TIME=$(get_total_cpu_time)
PREV_PROC_TIME=0

# Monitoring loop
while true; do
    if [ -e "/proc/$PROCESS_PID/stat" ] && [ -e "/proc/$PROCESS_PID/status" ]; then
        # Reading process CPU and memory usage
        PROC_INFO=$(cat /proc/$PROCESS_PID/stat)
        CPU_USAGE=$(echo $PROC_INFO | awk '{print $14+$15}')
        MEM_USAGE_KB=$(grep VmRSS /proc/$PROCESS_PID/status | awk '{print $2}')
        MEM_USAGE_MiB=$((MEM_USAGE_KB / 1024))
        VIRTUAL_MEM_KB=$(grep VmSize /proc/$PROCESS_PID/status | awk '{print $2}')
        VIRTUAL_MEM_MiB=$((VIRTUAL_MEM_KB / 1024))
        THREADS=$(grep Threads /proc/$PROCESS_PID/status | awk '{print $2}')
        PAGE_FAULTS=$(echo $PROC_INFO | awk '{print $9}')
        NOW=$(date "+%Y-%m-%d %H:%M:%S")

        # Calculating CPU usage percentage
        TOTAL_TIME=$(get_total_cpu_time)
        DELTA_TOTAL=$((TOTAL_TIME - PREV_TOTAL_TIME))
        DELTA_PROC=$((CPU_USAGE - PREV_PROC_TIME))
        if [ "$DELTA_TOTAL" -ne 0 ]; then
            CPU_PERCENTAGE=$(awk "BEGIN {print ($DELTA_PROC / $DELTA_TOTAL)*100}")
        else
            CPU_PERCENTAGE=0
        fi
        PREV_TOTAL_TIME=$TOTAL_TIME
        PREV_PROC_TIME=$CPU_USAGE

        # Writing data to CSV
        echo "$NOW;$CPU_PERCENTAGE;$MEM_USAGE_MiB;$MEM_USAGE_KB;$VIRTUAL_MEM_MiB;$VIRTUAL_MEM_KB;$THREADS;$PAGE_FAULTS" >> $CSV_FILE
    else
        echo "Process not found."
        break
    fi

    sleep $SLEEP_INTERVAL
done
