#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: $0 ip-address"
    exit 1
fi

target_url="http://$1//?page=recover"
response=$(curl -s "$target_url")
echo $response > index.html

