#!/usr/bin/env bash


hash="$1"
length=${#hash}
[ -z "$1" ] && exit 1

#hex check
if [[ "$hash" =~  ^[0-9a-fA-F]+$ ]]; then
     #length proccess
   [ $length -eq 32 ] && echo  " [ $hash ] hash type: MD5"
   [ $length -eq 40 ] && echo  " [ $hash ] hash type: SHA1"
   [ $length -eq 56 ] && echo  " [ $hash ] hash type: SHA224"
   [ $length -eq 64 ] && echo  " [ $hash ] hash type: SHA256"
   [ $length -eq 96 ] && echo  " [ $hash ] hash type: SHA384"
   [ $length -eq 128 ] && echo " [ $hash ] hash type: SHA512"
   [ $length -gt 128 ] || [ $length -lt 32 ]  && echo "[*] Unknown hash type.."
   
else
     echo "[!] error: not a valid hexademical string"
fi
