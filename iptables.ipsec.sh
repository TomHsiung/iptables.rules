#!/bin/bash
iptables -t mangle -I FORWARD 1 -m policy --pol ipsec --dir in --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:65495 -j TCPMSS --set-mss 1360
iptables -t mangle -I FORWARD 2 -m policy --pol ipsec --dir out --protocol TCP --tcp-flags SYN,RST SYN -m tcpmss --mss 1361:65495 -j TCPMSS --set-mss 1360
