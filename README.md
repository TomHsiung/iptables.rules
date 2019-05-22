# iptables.rules
iptables rules collection

# Contents
1) iptables.SNAT.sh is the necessary iptables rules for SNAT, inlcuding both fixed and dynamic gateway IP address. 
2) iptables.ipsec.sh is the necessary iptables rules for IPsec gateway aimed at negotiating the tcp packet size. 
3) iptables.tcpmss.clamp.sh is the clamp tcp msss rule.
4) iptables.ssh.secure is the preferred iptables rules for SSH security.

# How to use
Save the codes as a file on your server and execute it with root privilege.

#Notice
It is free to adjust the rules according to your specific needs.
