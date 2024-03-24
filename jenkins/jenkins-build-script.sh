#!/bin/bash

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
filename="/mnt/output_${timestamp}.log"

# Capture start time
start_time=$(get_current_time)

json_output="{\"start_time\": \"$start_time\"}"

echo "$json_output" > $filename

# Run stress command
stress --cpu 4 --io 2 --vm 1 --vm-bytes 128M --timeout 5s

# Capture end time
end_time=$(get_current_time)

# Create JSON output
json_output="{\"end_time  \": \"$end_time\"}"

# Write JSON output to file
echo "$json_output" >> $filename


# {"timestamp": "2024-03-22T12:00:00Z", "level": "INFO", "message": "Application started", "user_id": 12345}
# {"timestamp": "2024-03-22T12:01:00Z", "level": "DEBUG", "message": "Processing user request", "user_id": 12345}
# {"timestamp": "2024-03-22T12:02:00Z", "level": "WARN", "message": "Invalid user input detected", "user_id": 12346}
# {"timestamp": "2024-03-22T12:03:00Z", "level": "ERROR", "message": "Failed to process user request", "user_id": 12347, "error": "Database timeout"}

##############################################################################################################################################################

#!/bin/bash

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

# Capture start time
start_time=$(get_current_time)
echo $start_time
BUILD_START=$(date)
echo "Build started at: $BUILD_START"

# logstashSend failBuild: true, maxLines: 1000, message: [build_start: env.BUILD_START, other_data: 'value']

json_output="{\"start_time\": \"$start_time\"}"

echo "$json_output" > $filename

# Run stress command
stress --cpu 4 --io 2 --vm 1 --vm-bytes 128M --timeout 5s

# Capture end time
end_time=$(get_current_time)
echo $end_time
# Create JSON output
json_output="{\"end_time  \": \"$end_time\"}"

# Write JSON output to file
echo "$json_output" >> $filename
