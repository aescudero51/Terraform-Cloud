resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  # cidr_block = lookup(var.virginia_cidr,terraform.workspace) # proximo examen no se evaluara los workspace
   tags = {
    "Name"= "vpc_virginia-${local.sufix}"
  #   Owner = "alescude"
  #   Environment = "Dev"
  }
}

# resource "aws_vpc" "vpc_Ohio" {
#   cidr_block = var.ohio_cidr
#   tags = {
#     Name = "VPC_LAB_OHIO"
#     Owner = "alescude"
#     Environment = "Dev"
#   }
#   provider = aws.ohio
# }

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc_virginia.id
    # cidr_block = var.public_subnet
    cidr_block = var.subnets[0]
    map_public_ip_on_launch = true
    tags = {
      "Name" = "LAB_Public_Subnet-${local.sufix}"
  #     Owner = "alescude"
  #     Environment = "Dev"
  }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc_virginia.id
    # cidr_block = var.private_subnet
    cidr_block = var.subnets[1]
    tags = {
      "Name" = "LAB_Private_Subnet-${local.sufix}"
  #     Owner = "alescude"
  #     Environment = "Dev"
  }
  depends_on = [
        aws_subnet.public_subnet
  ]

  
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "igw_lab_terrom-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  # route {
  #   ipv6_cidr_block        = "::/0"
  #   egress_only_gateway_id = aws_egress_only_internet_gateway.example.id
  # }

  tags = {
    Name = "public_crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance" {
  name   = "sg public instance"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id = aws_vpc.vpc_virginia.id

  # ingress {
  #   description      = "SSH from VPC"
  #   from_port        = 22
  #   to_port          = 22
  #   protocol         = "tcp"
  #   cidr_blocks      = [var.sg_ingress_cidr]
  #   # ipv6_cidr_blocks = ["::/0"]
  # }
  # ingress {
  #   description      = "http over Internet"
  #   from_port        = 80
  #   to_port          = 80
  #   protocol         = "tcp"
  #   cidr_blocks      = [var.sg_ingress_cidr]
  #   # ipv6_cidr_blocks = ["::/0"]
  # }
  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks      = [var.sg_ingress_cidr]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg public instance-${local.sufix}"
  }
}