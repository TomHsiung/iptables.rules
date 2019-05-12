#For fixed gateway IP address
iptables -t nat -I POSTROUTING 1 -p tcp -s x.x.x.x/x -o ethx -j SNAT --to-source y.y.y.y:x-x'
iptables -t nat -I POSTROUTING 2 -p udp -s x.x.x.x/x -o ethx -j SNAT --to-source y.y.y.y:x-x'
iptables -t nat -I POSTROUTING 3 --protocol ICMP -s x.x.x.x/x -o ethx -j SNAT --to-source y.y.y.y:x-x'

#For dynamic gateway IP address
iptables -t nat -I POSTROUTING 1 -d x.x.x.x/x -o eth0 -p udp -m multiport --dports x,y -j MASQUERADE --to-ports x-x'
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
