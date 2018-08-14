#! /bin/bash

message="docker exec bro cat /config/feeds/testdata.txt"

echo "Running: $message"
$message

