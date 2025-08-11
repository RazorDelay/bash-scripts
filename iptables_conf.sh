[ "$EUID" -ne 0 ] && echo "[!] Please run as root or with sudo." && exit 1
command -v iptables >/dev/null 2>&1 || { sudo apt update && sudo apt install iptables -y &&
clear; }
command -v iptables-save >/dev/null || sudo apt install iptables-persistent -y




enableiptables() {

if ! systemctl is-active --quiet iptables; then
      sudo systemctl start iptables
      sudo systemctl enable iptables
fi

}



blockport() {


read -p "type the protocol: (tcp/udp)" prot
read -p "type the port number:" num

[ -z "$prot" ] && exit 99
[ -z "$num"  ] && exit 98

[ "$prot" = "udp" ] && iptables -A INPUT -p udp --dport $num -j DROP
[ "$prot" = "tcp" ] && iptables -A INPUT -p tcp --dport $num -j DROP
sudo sh -c "iptables-save > /etc/iptables/rules.v4"

}


openport() {

read -p "type the protocol: (tcp/udp)" prot
read -p "type the port number:" num

[ -z "$prot" ] && exit 99
[ -z "$num" ] && exit 98

[ "$prot" = "udp" ] && iptables -A INPUT -p udp --dport $num -j ACCEPT
[ "$prot" = "tcp" ] && iptables -A INPUT -p tcp --dport $num -j ACCEPT
sudo sh -c "iptables-save > /etc/iptables/rules.v4"

}

blockip() {


read -p "enter the ip:" ip

[ -z "$ip" ] && exit 99

clear
read -p  " (R)eject // (D)rop //:" opt

[ "$opt" = "R" ] && sudo iptables -A INPUT -s $ip -j REJECT
[ "$opt" = "D" ] && sudo iptables -A INPUT -s $ip -j DROP

}


enableiptables
clear

until [[ "$number" == "6" ]]; do

echo "==========/FIREWALL CONFIGURATION_demo\=========="
echo "  1.openport/ 2. denyport/ 3.blockip/ 4.showports/ 5.iplist/ 6.exit    "
read number

[ "$number" -eq 1 ] && openport
[ "$number" -eq 2 ] && blockport
[ "$number" -eq 3 ] && blockip
[ "$number" -eq 4 ] && sudo ss -tuln
[ "$number" -eq 5 ] && sudo ss -ntu

done
