output "PublicIP" {
  value = "${module.CloudSQL.public_ip_address}:3306"
}

output "AdminName" {
  value = local.AdminName
}

