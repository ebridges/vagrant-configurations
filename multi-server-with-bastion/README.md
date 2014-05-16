# Multi-server Network with Bastion Host

## Network Layout

```
    +---++-----------------+
    |   ||                 |
    |   ||     balancer    |
    | b ||                 |
    | a |+-----------------+
    | s |+--------++-------+
    | t ||        ||       |
    | i ||  http  || http  |
    | o ||        ||       |
    | n |+--------++-------+
    |   |+-----------------+
    |   ||                 |
    |   ||    database     |
    |   ||                 |
    +---++-----------------+
```
### Features

* Two tier application server structure.
* Round robin load balancer.
* Bastion server for SSH access to other servers.
  
## Firewall Rules

  Role           | Rules              | Source
-----------------|--------------------|----------
  Default        | `deny all/tcp`     | Anywhere
                 | `deny all/udp`     | Anywhere
  Bastion Server | `allow ssh/tcp`    | Anywhere
  Load Balancer  | `allow http/tcp`   | Anywhere
                 | `allow https/tcp`  | Anywhere
                 | `allow ssh/tcp`    | Bastion
  Web Server     | `allow http/tcp`   | Load Balancer
                 | `allow https/tcp`  | Load Balancer
                 | `allow ssh/tcp`    | Bastion
  DB Server      | `allow psql/tcp`   | Web Server
                 | `allow ssh/tcp`    | Bastion

## Connecting to Instances

### Configure Port Forwarding on local host

Edit `~/.ssh/config`:

```bash
Host balancer01 webserver01 webserver02 database01
  HostName 10.0.0.100
  User {{user}}
  Port 22
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile {{home}}/.ssh/id_rsa
  IdentitiesOnly yes
  LogLevel FATAL
  ForwardAgent yes
  ProxyCommand ssh -W %h:%p 10.0.0.10
```

### Ansible Configuration

In `~/.ansible.cfg`:

```
[ssh_connection]
  ssh_args = -o 'ProxyCommand ssh -W %h:%p 10.0.0.10'
```
