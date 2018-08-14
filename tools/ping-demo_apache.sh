#! /bin/bash

instance=$1
message="docker exec client ping demo_apache_$instance -c 1"

echo "Running: $message"
$message
