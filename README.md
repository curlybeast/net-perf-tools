# iptables-stats
AWK scripts to show statistics and more useful information about iptables rules being used. This allows all rules across all tables to be sorted and ordered by packets and bytes in descending order.

An example would be:
```
# ./iptables-stats.awk
------------|------------|----------|----------------------------
 Packets    | Bytes      | Table    | Rule
------------|------------|----------|----------------------------
     626622 |  111195672 | raw      | -P OUTPUT ACCEPT
     626621 |  111195568 | filter   | -P OUTPUT ACCEPT
     370149 |   78974024 | filter   | -A INPUT -j INPUT_SPI
     370149 |   78974024 | filter   | -A INPUT -j INPUT_IPSEC
     339559 |   68940104 | raw      | -P PREROUTING ACCEPT
     221314 |   45146866 | filter   | -A INPUT_SPI -m state --state NEW -j ACCEPT
     209322 |   34687200 | raw      | -A OUTPUT -p udp -m udp --dport 1491 -j NOTRACK
     148815 |   33826336 | filter   | -A INPUT_SPI -m state --state RELATED,ESTABLISHED -j ACCEPT
      84611 |   14138055 | raw      | -A PREROUTING -p udp -m udp --sport 1491 -j DROP
      19830 |    3328332 | nat      | -A POSTROUTING -j POST_NAT
      19830 |    3328332 | nat      | -A POSTROUTING -j POST_DMZ
      19830 |    3328332 | nat      | -A POSTROUTING -j POST_PORT_MAP
      19830 |    3328332 | nat      | -A POSTROUTING -j POST_PORT_TRG
      19830 |    3328332 | nat      | -A POSTROUTING -j POST_SNAT
      19830 |    3328332 | nat      | -A POSTROUTING -j POST_IPSEC
      18250 |    1531932 | filter   | -A OUTPUT -o br+ -p icmp -j ACCEPT
      18249 |    3214832 | nat      | -A POSTROUTING -j POST_LOCAL
      17088 |    3079648 | nat      | -P OUTPUT ACCEPT
      15819 |    2988786 | nat      | -A POSTROUTING -j MASQUERADE
      14414 |    1095337 | nat      | -A PRE_LOCAL -j PRE_DNS_PROXY
      14414 |    1095337 | nat      | -A PREROUTING -j PRE_LOCAL
      14414 |    1095337 | nat      | -A PREROUTING -j PRE_PORT_MAP
      14414 |    1095337 | nat      | -A PREROUTING -j PRE_PORT_TRG
      14414 |    1095337 | nat      | -A PREROUTING -j PRE_BOOSTER_REDIRECT
      13135 |    1012028 | nat      | -A PREROUTING -j PRE_DMZ
      13135 |    1012028 | nat      | -A PREROUTING -j PRE_SNAT
      13135 |    1012028 | nat      | -A PREROUTING -j PRE_UPNP
      12133 |     935736 | nat      | -P PREROUTING ACCEPT
      11049 |     615219 | filter   | -A FORWARD -j FWD_LOCK
      11049 |     615219 | filter   | -A FORWARD -j FWD_SNAT
      11049 |     615219 | filter   | -A FORWARD -j FWD_TCPMSS
      11049 |     615219 | filter   | -A FORWARD -j FWD_GENERAL
      11049 |     615219 | filter   | -A FORWARD -j FWD_URL_FILTER
      11049 |     615219 | filter   | -A FORWARD -j FWD_BOOSTER_WHITE_LIST
      11049 |     615219 | filter   | -A FORWARD -j FWD_FON
      10883 |     603373 | filter   | -A FWD_LOCK -i br+ ! -o br+ -j FWD_LOCK_LAN
      10740 |     592713 | filter   | -A FWD_LOCK_LAN -m state --state RELATED,ESTABLISHED -j ACCEPT
       5797 |    1162161 | filter   | -A INPUT ! -i lo -j INPUT_MGNT
       5797 |    1162161 | filter   | -A INPUT ! -i lo -j INPUT_MCAST
       5797 |    1162161 | filter   | -A INPUT ! -i lo -j INPUT_DLDIAGNOSE
       5641 |    1153545 | filter   | -A INPUT ! -i lo -j INPUT_VOIP
       5641 |    1153545 | filter   | -A INPUT ! -i lo -j INPUT_FW
       4708 |    1038826 | filter   | -A INPUT_MGNT -i br+ -j INPUT_MGNT_LAN
       4546 |    1029970 | filter   | -A INPUT_FW -i br+ -p udp -j INPUT_DOS_LAN
       4546 |    1029970 | filter   | -A INPUT_DOS_LAN -p udp -m limit --limit 100/sec --limit-burst 100 -m state --state INVALID,NEW -j RETURN
       1581 |     113500 | nat      | -A POST_NAT -o ppp0 -j POST_NAT_WAN0
       1545 |     107537 | nat      | -P INPUT ACCEPT
       1438 |     102840 | nat      | -A POST_NAT_WAN0 -s 10.0.0.0/8 -o ppp0 -j MASQUERADE
       1279 |      83309 | nat      | -A PRE_DNS_PROXY -s 192.168.1.0/24 ! -d 192.168.1.1/32 -i br0 -p udp -m udp --dport 53 -j DNAT --to-destination 192.168.1.1:53
       1089 |     123335 | filter   | -A INPUT_MGNT_WAN -i ppp0 -j INPUT_MGNT_WAN0
       1089 |     123335 | filter   | -A INPUT_MGNT ! -i br+ -j INPUT_MGNT_WAN
        899 |     112643 | filter   | -A INPUT_FW -i ppp0 -p udp -j INPUT_DOS_WAN0
        833 |     191991 | filter   | -A INPUT_FW -i br+ -p udp -m addrtype --dst-type BROADCAST -j INPUT_FRAGGLE_LAN
        833 |     191991 | filter   | -A INPUT_FRAGGLE_LAN -m limit --limit 10/sec --limit-burst 20 -j RETURN
        166 |      11846 | filter   | -A FWD_LOCK_WAN0 -i ppp0 -o br+ -m state --state RELATED,ESTABLISHED -j ACCEPT
        166 |      11846 | filter   | -A FWD_LOCK -i ppp0 -j FWD_LOCK_WAN0
        160 |       9052 | filter   | -A INPUT_FW -i ppp0 -p icmp -j INPUT_DOS_WAN0
        143 |      10660 | nat      | -A POST_NAT_WAN0 -s 192.168.0.0/16 -o ppp0 -j MASQUERADE
        143 |      10660 | filter   | -A FWD_VPN -j FWD_VPN_TO_LAN
        143 |      10660 | filter   | -A FWD_SPI_WAN0 -i br+ -o ppp0 -m state --state NEW -j ACCEPT
        143 |      10660 | filter   | -A FWD_SPI -o ppp0 -j FWD_SPI_WAN0
        143 |      10660 | filter   | -A FWD_POLICY -i br+ -j FWD_POLICY_IN_LAN
        143 |      10660 | filter   | -A FORWARD -j FWD_SPI
        143 |      10660 | filter   | -A FORWARD -j FWD_FW
        143 |      10660 | filter   | -A FORWARD -j FWD_ALG
        143 |      10660 | filter   | -A FORWARD -j FWD_VPN
        143 |      10660 | filter   | -A FORWARD -j FWD_DMZ
        143 |      10660 | filter   | -A FORWARD -j FWD_UPNP
        143 |      10660 | filter   | -A FORWARD -j FWD_PORT_MAP
        143 |      10660 | filter   | -A FORWARD -j FWD_PORT_TRG
        143 |      10660 | filter   | -A FORWARD -j FWD_POLICY
        136 |       7376 | filter   | -A INPUT_MGNT_LAN -p tcp -m tcp --dport 23 -j ACCEPT
         30 |       1640 | filter   | -A INPUT_FW -i ppp0 -p tcp -j INPUT_DOS_WAN0
         26 |       1560 | filter   | -A FWD_TCPMSS -p tcp -m tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
         17 |       1020 | nat      | -A PREROUTING -p tcp -m tcp --dport 80 -j PRE_REDIRECT
         17 |       1020 | nat      | -A PREROUTING -p tcp -m tcp --dport 80 -j PRE_WEB_PROXY
         15 |        804 | filter   | -A INPUT_MGNT_LAN -p tcp -m tcp --dport 80 -j ACCEPT
          7 |        500 | filter   | -A OUTPUT -p icmp -m state --state INVALID -j DROP
          5 |        372 | nat      | -A OUTPUT -o dummy0 -j OUTPUT_DMZ_WAN
          5 |        372 | nat      | -A OUTPUT -o dummy0 -j OUTPUT_PORT_TRG_WAN
          5 |        372 | nat      | -A OUTPUT -o dummy0 -j OUTPUT_PORT_MAP_WAN
          5 |        436 | filter   | -A INPUT_MGNT_LAN -p icmp -j ACCEPT
```


# pidstat-collect & pidstat-graph
A pair of AWK scripts which collect network data with process CPU load and graphs them side by side.

First, running `pidstat-collect` to collect data. Ths creates a file called `pidstat.tar`:
```
# pidstat-collect
Collecting stats over 30 seconds, minimum CPU threshold is 2%, using NICs eth0/eth3
Taring...
tar: Removing leading `/' from member names
Done
```
Second use `pidstat-graph` with the `pidstat.tar` file created:
```
# pidstat-graph pidstat.tar
Cleaning environment first...
Extracting data from './pidstat.tar'
Plotting now...
Adding to CPU plot for PID 1562
Adding to CPU plot for PID 1568
Adding to CPU plot for PID 2444
Adding to CPU plot for PID 8020
Adding to CPU plot for PID 14451
Adding to CPU plot for PID 14469
Adding to CPU plot for PID 26007
Adding to CPU plot for PID 31491
Adding to network plot
Using:
gnuplot -p -e 'set title "Graph to show CPU use per process
against network throughput over time";
set key autotitle columnheader;
set autoscale xfix;
set y2tics auto;
set ytics nomirror;
set xtics format "%S";
set timefmt "%H:%M:%S";
set xdata time;
set format y2 "%.0s%cB";
set xlabel "Seconds";
set ylabel "CPU %";
set y2label "Bytes / Second";
plot
"/tmp/pidstat-condensed-1562" using 1:6 title "gnome-terminal- (1562)" noenhanced smooth mcs with lines axis x1y1,
"/tmp/pidstat-condensed-1568" using 1:6 title "Xorg (1568)" noenhanced smooth mcs with lines axis x1y1,
"/tmp/pidstat-condensed-2444" using 1:6 title "gnome-shell (2444)" noenhanced smooth mcs with lines axis x1y1,
"/tmp/pidstat-condensed-8020" using 1:6 title "sublime_text (8020)" noenhanced smooth mcs with lines axis x1y1,
"/tmp/pidstat-condensed-14451" using 1:6 title "chromium (14451)" noenhanced smooth mcs with lines axis x1y1,
"/tmp/pidstat-condensed-14469" using 1:6 title "Compositor (14469)" noenhanced smooth mcs with lines axis x1y1,
"/tmp/pidstat-condensed-26007" using 1:6 title "chromium (26007)" noenhanced smooth mcs with lines axis x1y1,
"/tmp/pidstat-condensed-31491" using 1:6 title "chromium (31491)" noenhanced smooth mcs with lines axis x1y1,
"/tmp/pidstat-net" using 1:2 smooth mcs with lines lc rgb "red" lw 2 dt (5, 5, 5, 5) axis x1y2,
"/tmp/pidstat-net" using 1:3 smooth mcs with lines lc rgb "pink" lw 2 dt (5, 5, 5, 5) axis x1y2,
"/tmp/pidstat-net" using 1:4 smooth mcs with lines lc rgb "blue" lw 2 dt (5, 5, 5, 5) axis x1y2,
"/tmp/pidstat-net" using 1:5 smooth mcs with lines lc rgb "cyan" lw 2 dt (5, 5, 5, 5) axis x1y2;'
```

This produces graphs like:
(![Graph 1] https://github.com/curlybeast/net-perf-tools/raw/master/examples/30s-iperf3.png "iPerf3 over 30 seconds")
(![Graph 2] https://github.com/curlybeast/net-perf-tools/raw/master/examples/30s-idle.png "Idling over 30 seconds")

![Graph to show output][]