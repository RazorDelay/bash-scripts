#!/bin/bash

C_file="$1"

rm_comments() {

[ ! -f "$C_file" ] && echo "$C_file not found" && exit 99
perl -0777 -pe 's{/\*.*?\*/}{}gs; s{//.*?$}{}gm' "$input_file"

}

rm_comments
