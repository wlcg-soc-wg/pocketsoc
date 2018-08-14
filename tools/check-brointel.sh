#! /bin/bash

message="docker exec bro cat /opt/bro/logs/current/intel.log"

echo "Running: $message"
$message
