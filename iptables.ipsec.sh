#!/bin/bash
iptables -t mangle -I FORWARD 1 -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:65495 -j TCPMSS --set-mss 1360
iptables -t mangle -I FORWARD 2 -m policy --pol ipsec --dir out --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:65495 -j TCPMSS --set-mss 1360

# Bruce force attack prevention exception for IPsec traffics
iptables -t filter -I INPUT 1 -m policy --pol ipsec --dir in --protocol TCP --dport 22 -m state --state NEW -j ACCEPT

# Exception to masquerade rule(s) for packets about to pass through IPsec tunnel (strongSwan site-to-site mode)
iptables -t nat -I POSTROUTING x -s x.x.x.x/x -m policy --dir out --pol ipsec -j ACCEPT
