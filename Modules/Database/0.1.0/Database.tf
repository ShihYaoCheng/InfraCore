# https://registry.terraform.io/providers/winebarrel/mysql/latest/docs/resources/database
resource "mysql_database" "User" {
  depends_on            = [module.CloudSQL]
  name                  = "User"
  default_character_set = "utf8mb4"
  default_collation     = "utf8mb4_0900_ai_ci"
}

resource "mysql_database" "UserRel" {
  count = var.CloudSQLCreateReleaseUserAndDB ? 1 : 0

  depends_on            = [module.CloudSQL]
  name                  = "UserRel"
  default_character_set = "utf8mb4"
  default_collation     = "utf8mb4_0900_ai_ci"
}

resource "mysql_database" "Backstage" {
  depends_on            = [module.CloudSQL]
  name                  = "Backstage"
  default_character_set = "utf8mb4"
  default_collation     = "utf8mb4_0900_ai_ci"
}