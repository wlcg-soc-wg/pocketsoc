#! /bin/bash

message="docker exec zeek cat /opt/bro/logs/current/intel.log"

echo "Running: $message"
$message
