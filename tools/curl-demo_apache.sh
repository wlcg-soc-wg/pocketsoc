#! /bin/bash

instance=$1
message="docker exec client curl -s http://demo_apache_$instance"

echo "Running: $message"
$message
