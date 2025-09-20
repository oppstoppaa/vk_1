data "vkcs_compute_flavor" "mysql_flavor" {
  name = "STD3-2-8"
}

locals {
  db_instance_name = "YAKOVTSEVA-mysql"
  db_name          = "YAKOVTSEVA_database"
  volume_type      = "ceph-ssd"
  db_version       = "8.0"
  db_type          = "mysql"
  db_size          = 20
  zone             = "ME1"
}

resource "vkcs_db_instance" "mysql_instance" {
  name              = local.db_instance_name
  flavor_id         = data.vkcs_compute_flavor.mysql_flavor.id
  size              = local.db_size
  volume_type       = local.volume_type
  availability_zone = local.zone

  datastore {
    type    = local.db_type
    version = local.db_version
  }

  network {
    uuid = vkcs_networking_network.yakovtseva_private_net.id
  }

  floating_ip_enabled = true

  depends_on = [
    vkcs_networking_router_interface.yakovtseva_router_if
  ]
}

resource "time_sleep" "wait_for_mysql_ready" {
  depends_on = [vkcs_db_instance.mysql_instance]
  create_duration = "60s"
}

resource "vkcs_db_database" "test_database" {
  name    = local.db_name
  dbms_id = vkcs_db_instance.mysql_instance.id

  depends_on = [time_sleep.wait_for_mysql_ready]
}
