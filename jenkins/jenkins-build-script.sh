#!/bin/bash

echo "STARTED"

# Function to get current date and time in ISO 8601 format
get_current_time() {
    date +"%Y-%m-%dT%H:%M:%S%z"
}

generate_timestamp() {
    date +"%Y-%m-%d_%H-%M-%S"
}

# Generate timestamp
timestamp=$(generate_timestamp)

# Filename with timestamp
filename="/tmp/output_${timestamp}.log"

# Deploy tomcat 
kubectl -f apply /tmp/deploy-tomcat.yml

# Capture start time
start_time=$(get_current_time)
echo $start_time
BUILD_START=$(get_current_time)
echo "Build started at: $BUILD_START"

# logstashSend failBuild: true, maxLines: 1000, message: [build_start: env.BUILD_START, other_data: 'value']

json_output="{\"start_time\": \"$start_time\"}"

echo "$json_output" > $filename

# Run stress command
stress --cpu 4 --io 2 --vm 1 --vm-bytes 128M --timeout 5m

# Capture end time
end_time=$(get_current_time)
echo $end_time
# Create JSON output
json_output="{\"end_time  \": \"$end_time\"}"

# Write JSON output to file
echo "$json_output" >> $filename

BUILD_END=$(get_current_time)
echo "Build ended at: $BUILD_END"

echo "COMPLETED"
