#!/bin/bash
iptables -t mangle -A FORWARD -o eth0 -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1400:65495 -j TCPMSS --clamp-mss-to-pmtu
iptables -t mangle -I INPUT 1 -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:65495 -j TCPMSS --set-mss 1360
