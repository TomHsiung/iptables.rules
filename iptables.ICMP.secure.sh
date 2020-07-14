 # Let IPSec encrypted packets pass through
 iptables -t filter -I INPUT 1 -s x.x.x.x/x -i eth0 -m policy --pol ipsec --dir in --protocol ICMP -j ACCEPT
 
 # DROP general incoming packets
 iptables -t filter -I INPUT 2 -i eth0 --protocol ICMP -j DROP
