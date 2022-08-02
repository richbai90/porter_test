resource "libvirt_pool" "cluster" {
  name = "cluster"
  type = "dir"
  path = "${var.storage_pool}"
}

# Defining VM Volume
resource "libvirt_volume" "agent1-vol" {
  name = "agent1.qcow2"
  pool = "cluster" # List storage pools using virsh pool-list
  source = "${var.srcdir}/packer-rke-agent1"
  #source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

# Defining VM Volume
resource "libvirt_volume" "agent2-vol" {
  name = "agent2.qcow2"
  pool = "cluster" # List storage pools using virsh pool-list
  source = "${var.srcdir}/packer-rke-agent2"
  #source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

# Defining VM Volume
resource "libvirt_volume" "agent3-vol" {
  name = "agent3.qcow2"
  pool = "cluster" # List storage pools using virsh pool-list
  source = "${var.srcdir}/packer-rke-agent3"
  #source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

# Defining VM Volume
resource "libvirt_volume" "server-vol" {
  name = "server.qcow2"
  pool = "cluster" # List storage pools using virsh pool-list
  source = "${var.srcdir}/packer-rke-server"
  #source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

# Define KVM domain to create
resource "libvirt_domain" "agent1" {
  name   = "agent1"
  memory = "2048"
  vcpu   = 2

  network_interface {
    network_name = "default" # List networks with virsh net-list
  }

  disk {
    volume_id = "${libvirt_volume.agent1-vol.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = true
  }
}

resource "libvirt_domain" "agent2" {
  name   = "centos7"
  memory = "2048"
  vcpu   = 2

  network_interface {
    network_name = "default" # List networks with virsh net-list
  }

  disk {
    volume_id = "${libvirt_volume.agent2-vol.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = true
  }
}

resource "libvirt_domain" "agent3" {
  name   = "centos7"
  memory = "2048"
  vcpu   = 2

  network_interface {
    network_name = "default" # List networks with virsh net-list
  }

  disk {
    volume_id = "${libvirt_volume.agent3-vol.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = true
  }
}

resource "libvirt_domain" "server" {
  name   = "centos7"
  memory = "2048"
  vcpu   = 2

  network_interface {
    network_name = "default" # List networks with virsh net-list
  }

  disk {
    volume_id = "${libvirt_volume.server-vol.id}"
  }

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "vnc"
    listen_type = "address"
    autoport = true
  }
}

# Output Server IP
output "ip-agent1" {
  value = "${libvirt_domain.agent1.network_interface.0.addresses.0}"
}

output "ip-agent2" {
  value = "${libvirt_domain.agent2.network_interface.0.addresses.0}"
}

output "ip-agent3" {
  value = "${libvirt_domain.agent3.network_interface.0.addresses.0}"
}

output "ip-server" {
  value = "${libvirt_domain.server.network_interface.0.addresses.0}"
}