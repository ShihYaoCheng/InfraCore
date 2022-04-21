output "CloudSQLPublicIP" {
  value = "${module.CloudSQL.public_ip_address}:3306"
}

