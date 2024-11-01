resource "aws_s3_bucket" "lab_terraform_bucket" {
   bucket =  local.s3-sufix  #"lab-terraform-bucket-${random_string.sufijo[count.index].id}"
#   tags = {
#     Name        = "lab-terraform-bucket"
#     Environment = "Dev"
#     Owner       = "alescude@bancolombia.com.co"
#     Client      = "IngenieriaTi"
#   }
}