# consul-client-server
Basic consul LAB using Vagrant, contains one server and two clients: `server`, `client1` & `client2`.

# Topology
```
  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx
  x     server     x                  x     client1    x                  x     client2    x
  x consul server  x                  x consul client  x                  x consul client  x
  x                x                  x                x                  x                x
  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx
          | .81                               | .85                                    |.86
          |-----------------------------------|----------------------------------------|
                                       192.168.56.0/24       
```

# How to use this repo
Clone the repository and cd into it
```
git clone https://github.com/ion-consul/consul-client-server.git
```
```
cd consul-client-server.
```

Vagrant status to check available machines
```
vagrant status
```

Vagrant up
```
vagrant up
```

SSH into a specific machine using vagrant ssh <machine>
```
vagrant ssh server
```

Destroy the lab
```
vagrant destroy -f
```

# File structure
```
$ tree
.
├── LICENSE
├── README.md
├── Vagrantfile
├── conf
│   ├── client1
│   │   └── consul.hcl
│   ├── client2
│   │   └── consul.hcl
│   ├── consul-bash-env.sh
│   ├── consul.service
│   └── server
│       └── consul.hcl
└── scripts
    ├── client1.sh
    ├── client2.sh
    └── server.sh
```

# Sample output
## server
```
vagrant@server:~$ consul members
Node     Address             Status  Type    Build   Protocol  DC   Segment
server   192.168.56.81:8301  alive   server  1.10.4  2         dc1  <all>
client1  192.168.56.85:8301  alive   client  1.10.4  2         dc1  <default>
client2  192.168.56.86:8301  alive   client  1.10.4  2         dc1  <default>
vagrant@server:~$ 
```
```
vagrant@server:~$ consul operator raft list-peers 
Node    ID                                    Address             State   Voter  RaftProtocol
server  f85920c5-2b23-0ee9-2fa3-e9453a193a47  192.168.56.81:8300  leader  true   3
vagrant@server:~$ 
```
## client1
```
vagrant@client1:~$ systemctl status consul
● consul.service - "HashiCorp Consul - A service mesh solution"
   Loaded: loaded (/usr/lib/systemd/system/consul.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2021-11-16 11:10:31 UTC; 8min ago
     Docs: https://www.consul.io/
 Main PID: 14655 (consul)
    Tasks: 8 (limit: 1108)
   CGroup: /system.slice/consul.service
           └─14655 /usr/bin/consul agent -config-dir=/etc/consul.d/

Nov 16 11:10:31 client1 consul[14655]: 2021-11-16T11:10:31.714Z [INFO]  agent: (LAN) joining: lan_addresses=[192.168.56.81]
Nov 16 11:10:31 client1 consul[14655]: 2021-11-16T11:10:31.714Z [WARN]  agent.router.manager: No servers available
Nov 16 11:10:31 client1 consul[14655]: 2021-11-16T11:10:31.714Z [ERROR] agent.anti_entropy: failed to sync remote state: error="No known Consul servers"
Nov 16 11:10:31 client1 consul[14655]: 2021-11-16T11:10:31.716Z [INFO]  agent.client.serf.lan: serf: EventMemberJoin: server 192.168.56.81
Nov 16 11:10:31 client1 consul[14655]: 2021-11-16T11:10:31.717Z [INFO]  agent: (LAN) joined: number_of_nodes=1
Nov 16 11:10:31 client1 systemd[1]: Started "HashiCorp Consul - A service mesh solution".
Nov 16 11:10:31 client1 consul[14655]: 2021-11-16T11:10:31.718Z [INFO]  agent.client: adding server: server="server (Addr: tcp/192.168.56.81:8300) (DC: dc1)"
Nov 16 11:10:31 client1 consul[14655]: 2021-11-16T11:10:31.719Z [INFO]  agent: Join cluster completed. Synced with initial agents: cluster=LAN num_agents=1
Nov 16 11:10:32 client1 consul[14655]: 2021-11-16T11:10:32.902Z [INFO]  agent: Synced node info
Nov 16 11:11:44 client1 consul[14655]: 2021-11-16T11:11:44.295Z [INFO]  agent.client.serf.lan: serf: EventMemberJoin: client2 192.168.56.86
vagrant@client1:~$ 
```
```
vagrant@client1:~$ ip -o address
1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever preferred_lft forever
1: lo    inet6 ::1/128 scope host \       valid_lft forever preferred_lft forever
2: eth0    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0\       valid_lft 85820sec preferred_lft 85820sec
2: eth0    inet6 fe80::a00:27ff:febb:1475/64 scope link \       valid_lft forever preferred_lft forever
3: eth1    inet 192.168.56.85/24 brd 192.168.56.255 scope global eth1\       valid_lft forever preferred_lft forever
3: eth1    inet6 fe80::a00:27ff:fe12:a774/64 scope link \       valid_lft forever preferred_lft forever
vagrant@client1:~$ 
```
```
vagrant@client1:~$ consul members
Node     Address             Status  Type    Build   Protocol  DC   Segment
server   192.168.56.81:8301  alive   server  1.10.4  2         dc1  <all>
client1  192.168.56.85:8301  alive   client  1.10.4  2         dc1  <default>
client2  192.168.56.86:8301  alive   client  1.10.4  2         dc1  <default>
vagrant@client1:~$ 
```

## client2
```
vagrant@client2:~$ systemctl status consul
● consul.service - "HashiCorp Consul - A service mesh solution"
   Loaded: loaded (/usr/lib/systemd/system/consul.service; enabled; vendor preset: enabled)
   Active: active (running) since Mon 2021-11-15 22:30:26 UTC; 30min ago
     Docs: https://www.consul.io/
 Main PID: 3332 (consul)
    Tasks: 9 (limit: 1134)
   CGroup: /system.slice/consul.service
           └─3332 /usr/bin/consul agent -config-dir=/etc/consul.d/

Nov 15 22:30:26 client2 consul[3332]: 2021-11-15T22:30:26.664Z [INFO]  agent: (LAN) joining: lan_addresses=[192.168.56.70]
Nov 15 22:30:26 client2 consul[3332]: 2021-11-15T22:30:26.664Z [WARN]  agent.router.manager: No servers available
Nov 15 22:30:26 client2 consul[3332]: 2021-11-15T22:30:26.664Z [ERROR] agent.anti_entropy: failed to sync remote state: error="No known Consul servers"
Nov 15 22:30:26 client2 consul[3332]: 2021-11-15T22:30:26.672Z [INFO]  agent.client.serf.lan: serf: EventMemberJoin: server 192.168.56.70
Nov 15 22:30:26 client2 consul[3332]: 2021-11-15T22:30:26.673Z [INFO]  agent.client.serf.lan: serf: EventMemberJoin: client1 192.168.56.71
Nov 15 22:30:26 client2 consul[3332]: 2021-11-15T22:30:26.673Z [INFO]  agent.client: adding server: server="server (Addr: tcp/192.168.56.70:8300) (DC: dc
Nov 15 22:30:26 client2 consul[3332]: 2021-11-15T22:30:26.673Z [INFO]  agent: (LAN) joined: number_of_nodes=1
Nov 15 22:30:26 client2 consul[3332]: 2021-11-15T22:30:26.673Z [INFO]  agent: Join cluster completed. Synced with initial agents: cluster=LAN num_agents=
Nov 15 22:30:26 client2 systemd[1]: Started "HashiCorp Consul - A service mesh solution".
Nov 15 22:30:28 client2 consul[3332]: 2021-11-15T22:30:28.877Z [INFO]  agent: Synced node info
```

```
vagrant@client2:~$ ip -o address
1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever preferred_lft forever
1: lo    inet6 ::1/128 scope host \       valid_lft forever preferred_lft forever
2: eth0    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0\       valid_lft 85712sec preferred_lft 85712sec
2: eth0    inet6 fe80::a00:27ff:febb:1475/64 scope link \       valid_lft forever preferred_lft forever
3: eth1    inet 192.168.56.86/24 brd 192.168.56.255 scope global eth1\       valid_lft forever preferred_lft forever
3: eth1    inet6 fe80::a00:27ff:fe35:e633/64 scope link \       valid_lft forever preferred_lft forever
vagrant@client2:~$ 
```

```
vagrant@client2:~$ consul members
Node     Address             Status  Type    Build   Protocol  DC   Segment
server   192.168.56.81:8301  alive   server  1.10.4  2         dc1  <all>
client1  192.168.56.85:8301  alive   client  1.10.4  2         dc1  <default>
client2  192.168.56.86:8301  alive   client  1.10.4  2         dc1  <default>
vagrant@client2:~$
```
