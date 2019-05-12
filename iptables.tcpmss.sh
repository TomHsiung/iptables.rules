iptables -t mangle -A FORWARD -o eth0 -p tcp -m tcp --tcp-flags SYN,RST SYN -m tcpmss --mss 1400:65495 -j TCPMSS --clamp-mss-to-pmtu
