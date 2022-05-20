# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/database
resource "mysql_database" "User" {
  depends_on = [module.CloudSQL]
  name = "User"
}

resource "mysql_database" "Backstage" {
  depends_on = [module.CloudSQL]
  name = "Backstage"
}