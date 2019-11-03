#!/bin/bash
iptables -t filter -I INPUT 1 -m policy --pol ipsec --dir in --protocol TCP --dport 22 -m state --state NEW -j ACCEPT
iptables -t filter -I INPUT 2 -i eth0 -m tcp --protocol tcp --dport 22 -j DROP
iptables -A INPUT -i eth0 -m tcp --protocol tcp --dport 22 -m hashlimit --hashlimit-above 1/min --hashlimit-mode srcip --hashlimit-name SSH -m state --state NEW -j REJECT
