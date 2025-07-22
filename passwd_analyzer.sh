#!/bin/bash

file=/path/of/the/list
[ $(whoami) != "root" ] && echo "sudo privileges required" && exit 
[ -f "$file" ] &&  echo "[+] file found" ||  echo "[!] error: no such file "

file_check() {

passwd_count=$(cat "$file" | wc -l) 
size=$(stat -c%s "$file"| awk '{print $1/1024 " KB"}')

echo " [+] passwords available: $passwd_count"
echo " [%] size of the file: $size "
echo
}

check_length() {

for passwd in $( cat "$file" ); do
    echo "Password: $passwd "
    echo "Length: ${#passwd}"
    echo "Special Characters:"
    echo -n " {#}->"; echo "$passwd" | grep -o '#' | wc -l
    echo -n " {!}->"; echo "$passwd" | grep -o '!' | wc -l
    echo -n " {*}->"; echo "$passwd" | grep -o '*' | wc -l
    echo -n " {?}->"; echo "$passwd" | grep -o '?' | wc -l
    echo "------------------"
done
}

sleep 2
file_check
sleep 2
check_length 
