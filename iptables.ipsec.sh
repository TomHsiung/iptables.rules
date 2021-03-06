#!/bin/bash

# set the appropriate direction of iptables rules based on the packet flow direction
# For some reasons, packets not reaching the maximum MTU size would be fragmented. We use a value whcih equls 8 bytes substracting from the maximum MTU.

# tcpmss artificat modification in order to math MTU (two layers of tunnel)
iptables -t mangle -I FORWARD 1 -s x.x.x.x/x -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1325:65495 -j TCPMSS --set-mss 1324
iptables -t mangle -I FORWARD 2 -d x.x.x.x/x -m policy --pol ipsec --dir out --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1325:65495 -j TCPMSS --set-mss 1324
iptables -t mangle -I INPUT 1 -s x.x.x.x/x -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1325:65495 -j TCPMSS --set-mss 1324

# tcpmss artificat modification in order to match MTU (site-to-site mode)
iptables -t mangle -I FORWARD 1 -s x.x.x.x/x -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1389:65495 -j TCPMSS --set-mss 1388
iptables -t mangle -I FORWARD 2 -d x.x.x.x/x -m policy --pol ipsec --dir out --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1389:65495 -j TCPMSS --set-mss 1388
iptables -t mangle -I INPUT 1 -s x.x.x.x/x -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1389:65495 -j TCPMSS --set-mss 1388

# tcpmss artificat modification in order to match MTU (roadwarrior mode)
iptables -t mangle -I FORWARD 1 -s x.x.x.x/x -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:65495 -j TCPMSS --set-mss 1360
iptables -t mangle -I FORWARD 2 -s x.x.x.x/x -m policy --pol ipsec --dir out --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:65495 -j TCPMSS --set-mss 1360
iptables -t mangle -I INPUT 1 -s x.x.x.x/x -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:65495 -j TCPMSS --set-mss 1360

# Brute force attack prevention exception for IPsec traffics
iptables -t filter -I INPUT 1 -m policy --pol ipsec --dir in --protocol TCP --dport 22 -m state --state NEW -j ACCEPT

# Exception to masquerade rule(s) for packets about to pass through IPsec tunnel (strongSwan site-to-site mode)
iptables -t nat -I POSTROUTING x -s x.x.x.x/x -m policy --dir out --pol ipsec -j ACCEPT

# Port modification rules
iptables -t nat -I POSTROUTING 1 -d x.x.x.x/x -o eth0 -p udp -m multiport --dports xxx -j MASQUERADE --to-ports xxx-xxx
iptables -t nat -I PREROUTING 1 -d x.x.x.x/x -i eth0 -p udp -m multiport --dports xxx -j DNAT --to-destination x.x.x.x:xxx
iptables -t nat -I OUTPUT 1 -d x.x.x.x/x -o eth0 -p udp -m multiport --dports xxx -j DNAT --to-destination x.x.x.x:xxx
