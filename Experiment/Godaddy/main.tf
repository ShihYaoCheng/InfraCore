terraform {
  required_providers {
    godaddy = {
      source = "n3integration/godaddy"
      version = "1.8.7"
    }
  }
}

provider "godaddy" {
  key = ""
  secret = ""
}

variable "my-records" {
  type = list(object({name =string, type = string, data = string, ttl = number}))
  default = [
    {
      name = "qq"
      type = "A"
      data = "35.100.100.100"
      ttl = 3600
    },
    {
      name = "bb"
      type = "A"
      data = "35.100.100.150"
      ttl = 1600
    },
  ]
}

resource "godaddy_domain_record" "gd-fancy-domain" {
  domain   = "origingaia.com"

  // specify zero or more record blocks
  // a record block allows you to configure A, or NS records with a custom time-to-live value
  // a record block also allow you to configure AAAA, CNAME, TXT, or MX records
#  record {
#    name = "qq"
#    type = "A"
#    data = "35.100.100.100"
#    ttl = 3600
#  }

  dynamic "record" {
    for_each = var.my-records
    content  {
      name = record.value["name"]
      type = record.value["type"]
      data = record.value["data"]
      ttl = record.value["ttl"]
    }
  }
}