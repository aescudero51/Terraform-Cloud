variable "virginia_cidr" {
    description = "CIDR Virginia"
    type = string
    # type = map(string) # esta linea hace parte de los workspace que no se usara en el proximo exams
    sensitive = false
}
# variable "ohio_cidr" {
# }
# variable "public_subnet" {
#     description = "CIDER public subnet"
#     type = string

# }

# variable "private_subnet" {
#     description = "CIDER private subnet"
#     type = string

# }

variable "subnets" {
    description = "list of subnets"
    type = list(string)
}

variable "tags" {
    description = "project of tags"
    type = map(string)
}
 
variable "sg_ingress_cidr" {
    description = "CIDR fro ingress traffic"
    type = string
}

variable "ec2_specs" {
    description = "Parametros de la instancia"
    type = map(string)
}

variable "enable_monitoring" {
    description = "Habilitar el despliegue de un servidor de monitoreo"
    # type = bool
        type = number
}

variable "ingress_ports_list" {
    description = "List for port ingress"
    type = list(number)
}