terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 4.43.0, != 4.43.0, < 5.7.0"
        }
        random = {
            source = "hashicorp/random"
            version = "3.6.3"
        }
    }
    required_version = "~>1.9.0"
}
provider "aws" {
    region = "us-east-1"
    default_tags {
        tags = var.tags
    }
}

# provider "aws" {
#     region = "us-east-2"
#     alias = "ohio"
# }