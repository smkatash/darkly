#!bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: $0 ip-address"
    exit 1
fi

target_url="http://$1/index.php?page=b7e44c7a40c5f80139f0a50f3650fb2bd8d00b0d24667c4c2ca32c88e13b758f"

response=$(curl -s --referer "https://www.nsa.gov/" --user-agent "ft_bornToSec" "$target_url")
grep "flag" <<< "$response"
