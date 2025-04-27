#!/bin/sh

target_url="http://$1/$2/"
download_dir="$2"

mkdir -p "$download_dir"
wget -r -np -nH --no-parent "$download_dir" "$target_url"
grep -r "flag" "$download_dir"