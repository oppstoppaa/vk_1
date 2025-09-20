resource "vkcs_networking_network" "yakovtseva_private_net" {
  name           = "yakovtseva-db-net"
  admin_state_up = true
}

resource "vkcs_networking_subnet" "yakovtseva_private_subnet" {
  name        = "yakovtseva-db-subnet"
  network_id  = vkcs_networking_network.yakovtseva_private_net.id
  cidr        = "192.168.100.0/24"
  enable_dhcp = true

  dns_nameservers = [
    "8.8.8.8",
    "1.1.1.1"
  ]
}

data "vkcs_networking_network" "external_network" {
  name = "internet"
}


resource "vkcs_networking_router" "yakovtseva_router" {
  name                = "yakovtseva-router"
  external_network_id = data.vkcs_networking_network.external_network.id
  admin_state_up      = true
}

resource "vkcs_networking_router_interface" "yakovtseva_router_if" {
  router_id = vkcs_networking_router.yakovtseva_router.id
  subnet_id = vkcs_networking_subnet.yakovtseva_private_subnet.id
}
