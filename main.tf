resource "openstack_networking_floatingip_v2" "fip_1" {
  pool     = "Internet"
}

resource "openstack_blockstorage_volume_v3" "vm1-vol" {
  name     = "vm-1-vol"
  size     = 10
  image_id = "e91494fa-2c38-4718-ac24-82308c772c12"
}

resource "openstack_compute_instance_v2" "VM-1"{
  name            = "VM-1"
  flavor_name     = "m1.xlarge"
  key_pair        = "test_keypair"
  security_groups = ["default", "test_group"]

  block_device {
    uuid                  = "${openstack_blockstorage_volume_v3.vm1-vol.id}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    name = "test_net"
  }
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.fip_1.address
  instance_id = openstack_compute_instance_v2.VM-1.id
}

resource "openstack_blockstorage_volume_v3" "vm2-vol" {
  name     = "vm-2-vol"
  size     = 16
  image_id = "e91494fa-2c38-4718-ac24-82308c772c12"
}

resource "openstack_compute_instance_v2" "VM-2" {
  name            = "VM-2"
  flavor_name     = "m1.xlarge"
  key_pair        = "test_keypair"
  security_groups = ["default", "test_group"]

  block_device {
    uuid                  = "${openstack_blockstorage_volume_v3.vm2-vol.id}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    name = "test_net"
  }
}

resource "openstack_blockstorage_volume_v3" "vm3-vol" {
  name     = "vm-3-vol"
  size     = 16
  image_id = "e91494fa-2c38-4718-ac24-82308c772c12"
}

resource "openstack_compute_instance_v2" "VM-3" {
  name            = "VM-3"
  flavor_name     = "m1.xlarge"
  key_pair        = "test_keypair"
  security_groups = ["default", "test_group"]

  block_device {
    uuid                  = "${openstack_blockstorage_volume_v3.vm3-vol.id}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    name = "test_net"
  }
}

resource "openstack_networking_router_v2" "router_1" {
  name                = "main_router"
  admin_state_up      = true
  external_network_id = "2e6438ff-f5a1-42d8-860b-56def0320bff"
  external_subnet_ids = ["7d3044e1-d627-43b1-82f9-9dee85e0ac1f"]
  enable_snat = true
}

resource "openstack_networking_network_v2" "network_1" {
  name           = "test_net"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name = "subnet_192.168"
  network_id = "25a250b6-7075-4f86-bb68-220ad7aee6f7"
  cidr       = "192.168.100.0/24"
  allocation_pool {
  start = "192.168.100.2"
  end   = "192.168.100.200"
  }
  gateway_ip  = "192.168.100.1"
  enable_dhcp = true
  dns_nameservers = ["89.169.69.69", "77.88.8.8"]
}

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "test_group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_10248" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 10248
  port_range_max    = 10248
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_10248_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 10248
  port_range_max    = 10248
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_10250" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 10250
  port_range_max    = 10250
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_10250_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 10250
  port_range_max    = 10250
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_6443_in" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6443
  port_range_max    = 6443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_6443_out" {
  direction         = "egress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6443
  port_range_max    = 6443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_compute_keypair_v2" "test-keypair" {
  name       = "test_keypair"
}
