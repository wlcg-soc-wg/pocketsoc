#! /bin/bash

message="docker exec zeek /config/pull_misp.sh"

echo "Running: $message"
$message

