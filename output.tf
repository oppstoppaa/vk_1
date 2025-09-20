output "db_instance_identifier" {
  description = "ID инстанса базы данных MySQL Yakovtseva"
  value       = vkcs_db_instance.mysql_instance.id
}

output "db_name" {
  description = "Имя созданной базы данных Yakovtseva"
  value       = vkcs_db_database.test_database.name
}
