#!/bin/bash


tor=$(curl --socks5-hostname localhost:9050 -s https://check.torproject.org > /dev/null; echo $?)
[ "$tor" -gt 0 ] && echo " [!] check your tor connection." || echo " [+] under tor network."
