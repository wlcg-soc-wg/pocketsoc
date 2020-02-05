#! /bin/bash

message="docker exec zeek cat /config/feeds/testdata.txt"

echo "Running: $message"
$message

