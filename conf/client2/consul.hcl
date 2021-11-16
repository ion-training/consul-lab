node_name = "client2"
data_dir = "/opt/consul/"

server = false

bind_addr = "192.168.56.86"
client_addr = "0.0.0.0"

retry_join = ["192.168.56.81"]
