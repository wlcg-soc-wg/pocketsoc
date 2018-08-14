#! /bin/bash

message="docker exec bro /config/pull_misp.sh"

echo "Running: $message"
$message

