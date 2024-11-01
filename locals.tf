locals {
    sufix = "${var.tags.project_name}-${var.tags.env}-${var.tags.region}" #recurso-cerberus-prod-region
}

resource "random_string" "sufijo-s3" {
  length  = 8
  special = false
  upper   = false
  numeric = false

}

locals {
    s3-sufix = "${var.tags.project_name}-${random_string.sufijo-s3.id}"
}