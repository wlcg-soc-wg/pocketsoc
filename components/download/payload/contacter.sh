#! /bin/bash

for i in {1..100}; do
    curl -s http://target/ > /dev/null
    sleep 10
done
