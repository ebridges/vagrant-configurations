# Vagrant Load Balancer Configuration

A basic example of a multi-server configuration where the traffic from the public
server is load balanced between the configured private servers.

The public server uses a minimally configured Nginx server to distribute traffic
equally.

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

## Load Balancer Configuration

````
upstream cluster {
  server 10.0.0.10;
  server 10.0.0.11;
}

server {
  listen 80;
  server_name public100;

  location / {
    proxy_pass_header Host;
    proxy_pass http://cluster; 
  }
}
````