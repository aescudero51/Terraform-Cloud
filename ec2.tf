
variable "instance" {
  description     = "Name of the instance"
  type            = list(string) #Se usa cuando usamos el "count"
  # type            = set(string) #Se usa el set con for_each
  default         = ["apache"] # "postgres","mysql","jumpserver"
}

resource "aws_instance" "public_instance" {
  # count = length(var.instance)
  # for_each                = var.instance #Seusa el for_aech con un "set"
  for_each                = toset(var.instance)
  ami                     = var.ec2_specs.ami
  instance_type           = var.ec2_specs.instance_type
  subnet_id               = aws_subnet.public_subnet.id
  key_name                = data.aws_key_pair.key.key_name
  vpc_security_group_ids  = [aws_security_group.sg_public_instance.id]
  user_data               = file("userdata.sh")
  tags                    = {
                              "Name" = "${each.value}-${local.sufix}" #var.instance[count.index] #Se usa con la opcion de "count"
  }
}

# variable "cadena" {
#   type = string
#   default = "ami-123, AMI-AVV, ami-12f"
# }

# variable "palabra" {
#   type = list(string)
#   default = ["hole", "como", "estas"]
# }

# variable "entornos"{
#   type = map(string)
#   default = {
#     "prod" = "10.10.0.0/16"
#     "dev" = "172.16.0.0/16"
#   }
# }

resource "aws_instance" "monitoring_instance" {
  # count = length(var.instance)
  # for_each                = var.instance #Seusa el for_aech con un "set"
  # for_each                = toset(var.instance)
  # count                   = var.enable_monitoring ? 1 : 0
  count                   = var.enable_monitoring == 1 ? 1 : 0
  ami                     = var.ec2_specs.ami
  instance_type           = var.ec2_specs.instance_type
  subnet_id               = aws_subnet.public_subnet.id
  key_name                = data.aws_key_pair.key.key_name
  vpc_security_group_ids  = [aws_security_group.sg_public_instance.id]
  user_data               = file("userdata.sh")
  tags                    = {
                              "Name" = "Monitoring-${local.sufix}"
  }
}
