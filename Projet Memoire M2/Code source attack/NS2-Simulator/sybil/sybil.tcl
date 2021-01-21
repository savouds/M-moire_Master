# Define options
set val(chan)           Channel/WirelessChannel                  ;#Channel Type
set val(prop)           Propagation/TwoRayGround                 ;# radio-propagation model
set val(netif)          Phy/WirelessPhy                          ;# network interface type
set val(mac)            Mac/802_11                               ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue                  ;# interface queue type
set val(ll)             LL                                       ;# link layer type
set val(ant)            Antenna/OmniAntenna                      ;# antenna model
set val(ifqlen)         150                                      ;# max packet in ifq
set val(nn)             15                                       ;# total number of mobilenodes
set val(rp)             AODV                                     ;# routing protocol
set val(x)              700                                      ;# X dimension of topography
set val(y)              700                                      ;# Y dimension of topography
set val(cstop)          10                                      ;# time of connections end
set val(stop)           10                                     ;# time of simulation end


set ns_ [new Simulator]

$ns_ use-newtrace
set tracefd [open AODV.tr w]
$ns_ trace-all $tracefd

set namtrace [open sav.nam w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)

set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

set chan_1_ [new $val(chan)]
set chan_2_ [new $val(chan)]

$ns_ node-config        -adhocRouting $val(rp) \
                        -llType $val(ll) \
                        -macType $val(mac) \
                        -ifqType $val(ifq) \
                        -ifqLen $val(ifqlen) \
                        -antType $val(ant) \
                        -propType $val(prop) \
                        -phyType $val(netif) \
                        -topoInstance $topo \
                        -agentTrace ON \
                        -routerTrace ON \
                        -macTrace ON \
                        -movementTrace ON \
                        -channel $chan_1_
						
set node_(0) [$ns_ node]
set node_(1) [$ns_ node]
set node_(2) [$ns_ node]
set node_(3) [$ns_ node]
set node_(4) [$ns_ node]
set node_(5) [$ns_ node]
set node_(6) [$ns_ node]
set node_(7) [$ns_ node]
set node_(8) [$ns_ node]
set node_(9) [$ns_ node]
set node_(10) [$ns_ node]
set node_(11) [$ns_ node]
set node_(12) [$ns_ node]
set node_(13) [$ns_ node]
set node_(14) [$ns_ node]


$node_(0) set X_ 23.5753
$node_(0) set Y_ 170.686
$node_(0) set Z_ 0.0

$node_(1) set X_ 170.0
$node_(1) set Y_ 250.0
$node_(1) set Z_ 0.0

$node_(2) set X_ 138.848
$node_(2) set Y_ 36.393
$node_(2) set Z_ 0.0

$node_(3) set X_ 280.208
$node_(3) set Y_ 217.918
$node_(3) set Z_ 0.0

$node_(4) set X_ 346.623
$node_(4) set Y_ 248.076
$node_(4) set Z_ 0.0

$node_(5) set X_ 148.016
$node_(5) set Y_ 139.754
$node_(5) set Z_ 0.0

$node_(6) set X_ 285.929
$node_(6) set Y_ 105.721
$node_(6) set Z_ 0.0

$node_(7) set X_ 353.368
$node_(7) set Y_ 130.925
$node_(7) set Z_ 0.0

$node_(8) set X_ 213.057
$node_(8) set Y_ 174.431
$node_(8) set Z_ 0.0

$node_(9) set X_ 341.334
$node_(9) set Y_ 204.175
$node_(9) set Z_ 0.0

$node_(10) set X_ 110.95
$node_(10) set Y_ 248.678
$node_(10) set Z_ 0.0

$node_(11) set X_ 232.06
$node_(11) set Y_ 118.262
$node_(11) set Z_ 0.0

$node_(12) set X_ 287.525
$node_(12) set Y_ 178.115
$node_(12) set Z_ 0.0

$node_(13) set X_ 219.044
$node_(13) set Y_ 213.508
$node_(13) set Z_ 0.0

$node_(14) set X_ 138.924
$node_(14) set Y_ 175.022
$node_(14) set Z_ 0.0

set god_ [God instance]

set udp [new Agent/UDP]
$ns_ attach-agent $node_(0) $udp
set null [new Agent/Null]
$ns_ attach-agent $node_(4) $null

set cbr [new Application/Traffic/CBR]
$cbr set packet_size_ 512
$cbr set interval_ 1
$cbr set rate_ 10kb
$cbr set random_ false
$cbr attach-agent $udp
$ns_ connect $udp $null

$ns_ at 0.01 "$cbr start"
$ns_ at 0.01 "$node_(0) label \"Source\""
$ns_ at 0.01 "$node_(4) label \"Destination1\""

$ns_ at 0.01 "$node_(0) add-mark N0 blue circle"
$ns_ at 0.01 "$node_(4) add-mark N11 blue circle"

set udp1 [new Agent/UDP]
$ns_ attach-agent $node_(0) $udp1
set null1 [new Agent/Null]
$ns_ attach-agent $node_(7) $null1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packet_size_ 512
$cbr1 set interval_ 1
$cbr1 set rate_ 10kb
$cbr1 set random_ false
$cbr1 attach-agent $udp1
$ns_ connect $udp1 $null1

$ns_ at 5.0 "$cbr1 start"
$ns_ at 5.0 "$node_(7) label \"Destination2\""

$ns_ initial_node_pos $node_(0) 10
$ns_ initial_node_pos $node_(1) 10
$ns_ initial_node_pos $node_(2) 10
$ns_ initial_node_pos $node_(3) 10
$ns_ initial_node_pos $node_(4) 10
$ns_ initial_node_pos $node_(5) 10
$ns_ initial_node_pos $node_(6) 10
$ns_ initial_node_pos $node_(7) 10
$ns_ initial_node_pos $node_(8) 10
$ns_ initial_node_pos $node_(9) 10
$ns_ initial_node_pos $node_(10) 10
$ns_ initial_node_pos $node_(11) 10
$ns_ initial_node_pos $node_(12) 10
$ns_ initial_node_pos $node_(13) 10
$ns_ initial_node_pos $node_(14) 10

#$ns_ at 3.0 "[$node_(2) set ragent_] malicious"
$ns_ at 3.0 "$node_(2) label \"Sybil\""
$ns_ at 3.0 "$node_(2) add-mark N1 red circle"

set null_(2) [new Agent/Null]
$ns_ attach-agent $node_(4) $null_(2)

set udp_(2) [new Agent/UDP]
$ns_ attach-agent $node_(2) $udp_(2)

set cbr_(2) [new Application/Traffic/CBR]
#$cbr_(3) set interval_ 2.0
$cbr_(2) set random_ 1
#   $cbr_(1) set maxpkts_ 100
$cbr_(2) attach-agent $udp_(2)
$ns_ connect $udp_(2) $null_(2)
$ns_ at 5.0 "$cbr_(2) start"
$ns_ at 7.0 "$cbr_(2) stop"

$ns_ at $val(cstop) "$cbr stop"
$ns_ at $val(cstop) "$cbr1 stop"

$ns_ at $val(stop).000000001 "$node_(0) reset";
$ns_ at $val(stop).000000001 "$node_(1) reset";
$ns_ at $val(stop).000000001 "$node_(2) reset";
$ns_ at $val(stop).000000001 "$node_(3) reset";
$ns_ at $val(stop).000000001 "$node_(4) reset";
$ns_ at $val(stop).000000001 "$node_(5) reset";
$ns_ at $val(stop).000000001 "$node_(6) reset";
$ns_ at $val(stop).000000001 "$node_(7) reset";
$ns_ at $val(stop).000000001 "$node_(8) reset";
$ns_ at $val(stop).000000001 "$node_(9) reset";
$ns_ at $val(stop).000000001 "$node_(10) reset";
$ns_ at $val(stop).000000001 "$node_(11) reset";

$ns_ at $val(stop).000000001 "$node_(12) reset";
$ns_ at $val(stop).000000001 "$node_(13) reset";
$ns_ at $val(stop).000000001 "$node_(14) reset";
$ns_ at $val(stop) "finish"

$ns_ at 1.0 "Graph"
set g [open AODV.tr w]

proc finish {} {
global ns_ tracefd namtrace
$ns_ flush-trace
close $tracefd
close $namtrace
#exec sav.nam &
#exec xgraph AODV.tr -geometry 800x400 &
exit 0
}

proc Graph {} { 
global ns_ tracefd
set ns_ [Simulator instance]
set time 1.0
set now [$ns_ now]
puts $tracefd "[expr rand()*8][expr rand()*6]"
$ns_ at [expr $now+$time]"Graph"
}


puts "Starting Simulation..."
$ns_ run
