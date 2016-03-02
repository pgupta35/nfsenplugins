# Plugin Development Requirements and Details #

Internal IP space:  151.102.0.0/16 (public IP), 117.0.0.0/8 (private IP)

**Command and Control Servers**
  * list will be provided offline from Information Security.
  * based on DST IP traffic
  * capture SRC IP addresses (PERL) and track via PHP
  * capture DST Ports/statistics (PERL) and track via PHP

`src host 8.235.238.65 or src host 209.147.146.78 or src host 5.151.51.145 or src host 209.237.7.136`

**SPAM/Phishing detection via SMTP**
  * DST traffic on 25, 465, other SMTP ports
  * capture SRC IP addresses (PERL) and track via PHP
  * Track via PHP

`(src net 151.102.0.0/16 or src net 117.0.0.0/8) and (dst port 25 or dst port 465) and not (host 151.102.2.209 or host 151.102.2.2 or host 151.102.2.211)`



**IRC C&C communication**
  * Pattern:  TCP Port 6662-6669
  * Track DST IP as well as SRC IP (PERL).
  * Detect if internal host hosting IRC services (PERL).
  * capture SRC IP addresses (PERL) and track via PHP

> example syntax:  dst port > 6660 and dst port < 6669
`not (dst net 151.102.0.0/16 or dst net 117.0.0.0/8) and (dst port > 6660 and dst port < 6670)`



**Aggregate Detection**
  * Detect firing of plugins (PERL).
  * capture SRC IP of host causing plugin firing (PERL).
  * Multiple plugins firing per single host gives greater "weight" (PERL).
  * Track "weight" (ie: assurance) via PHP.