variable "profile" {
    type =  string
    description = "Perfil aws credentials "
    default = "default"
}

variable "version_k8s" {
    type =  string
    description = "Versão do kubernetes "
    default = "1.25"
}

variable "username" {
    type = string
    description = "Username para login"
    default =  "ubuntu"
}

variable "region" {
    type = string
    description = "Região AWS"
    default =  "us-east-1"
}

variable "instance_type" {
    type = string
    description = "Tipo da Instancia Ec2"
    default =  "t3.small"
}