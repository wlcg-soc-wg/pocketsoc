# tcpreplay notes

tcpreplay -K -v -l 5 --unique-ip -i eth0 laptop-prague.pcap

##   -v, --verbose              Print decoded packets via tcpdump to STDOUT

Prints out packet info to screen

##   -K, --preload-pcap         Preloads packets into RAM before sending

Preloads to memory

##   -i, --intf1=str            Client to server/RX/primary traffic output interface

Interface; should be eth0 for zeek container

##    -l, --loop=num             Loop through the capture file X times
##       --loopdelay-ms=num     Delay between loops in milliseconds

Loop settings

##   -p, --pps=str              Replay packets at a given packets/sec
##   -M, --mbps=str             Replay packets at a given Mbps
##   -t, --topspeed             Replay packets as fast as possible

Rate setting

##       --unique-ip            Modify IP addresses each loop iteration to generate unique flows
##       --unique-ip-loops=str  Number of times to loop before assigning new unique ip

Unique IP options


