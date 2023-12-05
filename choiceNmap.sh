#!/bin/bash

# Author: @4ndymcfly
# Date:   11/2023

blueColor="\e[0;34m\033[1m"
grayColor="\e[0;37m\033[1m"
endColor="\033[0m\e[0m"

if [ "$#" -ne 1 ]; then
    echo -e "\nCHOICE NMAP\nUsage: ${blueColor}$0${endColor} <ip_address>"
    exit 1
fi

if ! [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Invalid IP address format."
    echo "Please provide a valid IP address as an argument."
    exit 1
fi

ip=$1

echo -e "\n${blueColor}CHOICE NMAP${endColor}\nby: @4ndymcfly\n"
echo -e "\n${blueColor}Select an option:${endColor}\n"
echo -e "${blueColor}[1]${endColor} Fast scan (top 1000 ports)."
echo -e "${blueColor}[2]${endColor} Normal full scan (all ports and services)"
echo -e "${blueColor}[3]${endColor} Vulns scan (may take a long time)"
echo -e "${blueColor}[4]${endColor} UDP full port scan."
echo -e "${blueColor}[5]${endColor} Exit.\n"
read -p "Enter an option: " option

if [ $option == 5 ]
then
	echo -e "\n${blueColor}Exiting...${endColor}\n"
	exit 0
fi

fileName=""

case $option in
	1)
		echo -e "\n${blueColor}[i] Starting the fast port scan...${endColor}"
		sudo nmap -sS --top-ports 1000 --open --min-rate 5000 -n -Pn $ip -oG fastPorts > /dev/null
		TTL=$(sudo ping -c 1 $ip | grep ttl | awk '{print $6}' | cut -d "=" -f2)  > /dev/null
		fileName="fastPorts"
		;;
	2|3)
		echo -e "\n${blueColor}[i] Starting the scan of all ports...${endColor}"
		sudo nmap -sS -p- --open --min-rate 5000 -n -Pn $ip -oG allPorts > /dev/null
		TTL=$(sudo ping -c 1 $ip | grep ttl | awk '{print $6}' | cut -d "=" -f2)  > /dev/null
		fileName="allPorts"
		;;
	4)
		echo -e "\n${blueColor}[i] Starting the UDP port scan...${endColor}"
		sudo nmap -sU --open --min-rate 5000 -n -Pn $ip -oG allPortsUDP > /dev/null
		TTL=$(sudo ping -c 1 $ip | grep ttl | awk '{print $6}' | cut -d "=" -f2)  > /dev/null
		fileName="allPortsUDP"
		;;
	*)
		echo -e "${redColor}Invalid option. Exiting...${endColor}"
		exit 1
		;;
esac

portsContent=$(cat ./$fileName)
ip_address=$(echo "$portsContent" | grep -oP '^Host: .* \(\)' | head -n 1 | awk '{print $2}')
open_ports=$(echo "$portsContent" | grep -oP '\d{1,5}/open' | awk '{print $1}' FS="/" | xargs | tr ' ' ',')
num_ports=$(echo $open_ports | tr ',' '\n' | wc -l)

echo -e "\n"
echo -e "\t${blueColor}[*] IP:\t\t\t ${grayColor}$ip_address${endColor}\n"
if [ $option == 1 ] || [ $option == 2 ] || [ $option == 3 ] || [ $option == 4 ]; then
	if [ $TTL -ge 120 ] && [ $TTL -le 130 ]
	then
		echo -e "\t${blueColor}[*] OS detected:\t ${grayColor}Windows${endColor}\n"
	elif [ $TTL -ge 60 ] && [ $TTL -le 70 ]
	then
		echo -e "\t${blueColor}[*] OS detected:\t ${grayColor}Linux${endColor}\n"
	else
		echo "\t${blueColor}[!]${endColor} Could not determine the operating system.\n"
	fi
fi
echo -e "\t${blueColor}[*] Found $num_ports Ports:\t ${grayColor}$open_ports${endColor}\n\n"
echo $open_ports | tr -d '\n' | xclip -sel clip

case $option in
	1|2)
		echo -e "${blueColor}[i] Starting the scan on the found ports...${endColor}"
		sudo nmap -sCV -p $open_ports $ip --stylesheet=https://raw.githubusercontent.com/honze-net/nmap-bootstrap-xsl/stable/nmap-bootstrap.xsl -oN targeted -oX targeted.xml > /dev/null
		;;
	3)
		echo -e "${blueColor}[i] Starting the exhaustive scan on the found ports. May take a long time, wait...${endColor}"
		sudo nmap -sCV -O -p $open_ports --script vuln --version-all --reason --osscan-guess --traceroute $ip --stylesheet=https://raw.githubusercontent.com/honze-net/nmap-bootstrap-xsl/stable/nmap-bootstrap.xsl -oN targeted -oX targeted.xml > /dev/null
		;;
	4)
		echo -e "${blueColor}[i] Starting the vulnerability scan on the found UDP ports...${endColor}"
		sudo nmap -sCV -O -p $open_ports --script vuln --version-all --reason --osscan-guess --traceroute $ip --stylesheet=https://raw.githubusercontent.com/honze-net/nmap-bootstrap-xsl/stable/nmap-bootstrap.xsl -oN targetedUDP -oX targetedUDP.xml > /dev/null
		/usr/bin/cat ./targetUDP
  		exit 0
  		;;
esac

/usr/bin/cat ./targeted
