node_name = "server"
data_dir = "/opt/consul/"

server = true
bootstrap_expect = 1

ui_config {
    enabled = true
    }

bind_addr = "192.168.56.81"
client_addr = "0.0.0.0"

retry_join = ["192.168.56.81"]
