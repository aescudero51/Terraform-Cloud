virginia_cidr = "10.10.0.0/16"
# ohio_cidr = "10.20.0.0/16"
# public_subnet = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

#Workspace no se evaluara en el proximo examen
# virginia_cidr ={
#     "prod" = "10.10.0.0/16"
#     "qa"   = "10.10.1.0/24"
#     "dev"  = "172.16.0.0/16"
# }

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
    "env"               = "dev"
    "owner"             = "alescude"
    "cloud"             = "AWS"
    "Iac"               = "terraform"
    "application_code" = "cld10010001"
    "project_name"      = "Terraform_Cerberus"
    "region"            = "us-east-1"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
    "description"       = "Parametros de la instancia"
    "ami"               = "ami-06b21ccaeff8cd686"
    "instance_type"     = "t2.micro" 
}

# enable_monitoring = true
enable_monitoring = 0

ingress_ports_list = [22, 80, 443]