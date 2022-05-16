# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/database
resource "mysql_database" "User" {
  name = "User"
}

resource "mysql_database" "Backstage" {
  name = "Backstage"
}