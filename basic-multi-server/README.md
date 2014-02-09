# Vagrant Multiple Server Configuration

A basic example multi-server configuration layout.  Does not do any provisioning, just sets up the network.

## Network Layout

````
                               dhcp
                        +----------------+
                        |      eth1      |
        +------------------------------------------------+
        |                                                |
        |                   public100                    |
        |                                                |
        +---------------+----------------+---------------+
        |     eth0      |                |      eth2     |
        +---------------+                +---------------+
             10.0.2.15                       10.0.0.100


       +---------------------+       +---------------------+
       |                     |       |                     |
       |      private010     |       |      private011     |
       |                     |       |                     |
       +---------------------+       +---------------------+
         | eth0 |   | eth1 |           | eth0 |   | eth1 |
         +------+   +------+           +------+   +------+
        10.0.2.15  10.0.0.010         10.0.2.15  10.0.0.011

````

## Routing Table

### Public

````
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         10.0.2.2        0.0.0.0         UG    100    0        0 eth0
10.0.0.0        *               255.255.255.0   U     0      0        0 eth2
10.0.2.0        *               255.255.255.0   U     0      0        0 eth0
192.168.1.0     *               255.255.255.0   U     0      0        0 eth1
````

### Private

````
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         10.0.2.2        0.0.0.0         UG    100    0        0 eth0
10.0.0.0        *               255.255.255.0   U     0      0        0 eth1
10.0.2.0        *               255.255.255.0   U     0      0        0 eth0
````