# iptables.rules
iptables rules collection

# Contents
1) iptables.SNAT.sh is the necessary iptables rules for SNAT, inlcuding both fixed and dynamic gateway IP address. 
2) iptables.ipsec.sh is the necessary iptables rules for IPsec gateway aimed at negotiating the tcp packet size. 
3) iptables.tcpmss.clamp.sh is the clamp tcp msss rule.
4) iptables.ssh.secure is the preferred iptables rules for SSH security.

# How to use
Save the codes as a file on your server and execute it with root privilege.

# Notice
It is free to adjust the rules according to your specific needs.

# Additional inforamtion

1) hashlimit

hashlimit uses hash buckets to express a rate limiting match (like the limit match) for a group of connections using a single iptables rule. Grouping can be done per-hostgroup (source and/or destination address) and/or per-port. It gives you the ability to express "N packets per time quantum per group" or "N bytes per seconds" (see below for some examples).
A hash limit option (--hashlimit-upto, --hashlimit-above) and --hashlimit-name are required.

--hashlimit-upto amount[/second|/minute|/hour|/day]
Match if the rate is below or equal to amount/quantum. It is specified either as a number, with an optional time quantum suffix (the default is 3/hour), or as amountb/second (number of bytes per second).

--hashlimit-above amount[/second|/minute|/hour|/day]
Match if the rate is above amount/quantum.

--hashlimit-burst amount
Maximum initial number of packets to match: this number gets recharged by one every time the limit specified above is not reached, up to this number; the default is 5. When byte-based rate matching is requested, this option specifies the amount of bytes that can exceed the given rate. This option should be used with caution -- if the entry expires, the burst value is reset too.

--hashlimit-mode {srcip|srcport|dstip|dstport},...
A comma-separated list of objects to take into consideration. If no --hashlimit-mode option is given, hashlimit acts like limit, but at the expensive of doing the hash housekeeping.

--hashlimit-srcmask prefix
When --hashlimit-mode srcip is used, all source addresses encountered will be grouped according to the given prefix length and the so-created subnet will be subject to hashlimit. prefix must be between (inclusive) 0 and 32. Note that --hashlimit-srcmask 0 is basically doing the same thing as not specifying srcip for --hashlimit-mode, but is technically more expensive.

--hashlimit-dstmask prefix
Like --hashlimit-srcmask, but for destination addresses.

--hashlimit-name foo
The name for the /proc/net/ipt_hashlimit/foo entry.

--hashlimit-htable-size buckets
The number of buckets of the hash table

--hashlimit-htable-max entries
Maximum entries in the hash.

--hashlimit-htable-expire msec
After how many milliseconds do hash entries expire.

--hashlimit-htable-gcinterval msec
How many milliseconds between garbage collection intervals.

--hashlimit-rate-match
Classify the flow instead of rate-limiting it. This acts like a true/false match on whether the rate is above/below a certain number

--hashlimit-rate-interval sec
Can be used with --hashlimit-rate-match to specify the interval at which the rate should be sampled

Examples:

matching on source host
"1000 packets per second for every host in 192.168.0.0/16" => -s 192.168.0.0/16 --hashlimit-mode srcip --hashlimit-upto 1000/sec

matching on source port
"100 packets per second for every service of 192.168.1.1" => -s 192.168.1.1 --hashlimit-mode srcport --hashlimit-upto 100/sec

matching on subnet
"10000 packets per minute for every /28 subnet (groups of 8 addresses) in 10.0.0.0/8" => -s 10.0.0.0/8 --hashlimit-mask 28 --hashlimit-upto 10000/min

matching bytes per second
"flows exceeding 512kbyte/s" => --hashlimit-mode srcip,dstip,srcport,dstport --hashlimit-above 512kb/s

matching bytes per second
"hosts that exceed 512kbyte/s, but permit up to 1Megabytes without matching" --hashlimit-mode dstip --hashlimit-above 512kb/s --hashlimit-burst 1mb
