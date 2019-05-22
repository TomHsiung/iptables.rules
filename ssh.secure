sudo iptables -A INPUT -i eth0 -m tcp --protocol tcp --dport 22 -m hashlimit --hashlimit-above 1/min --hashlimit-mode srcip --hashlimit-name SSH -m state --state NEW -j REJECT
