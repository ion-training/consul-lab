# consul-client-server
Basic consul LAB using Vagrant, contains one server and two clients: `server`, `client1` & `client2`.

# Topology
```
  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx
  x     server     x                  x     client1    x                  x     client2    x
  x consul server  x                  x consul client  x                  x consul client  x
  x                x                  x                x                  x                x
  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx
          | .70                               | .71                                    |.72
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
