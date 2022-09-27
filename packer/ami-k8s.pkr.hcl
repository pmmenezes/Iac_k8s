packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.4"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "node_k8s" {
  profile = var.profile
  shared_credentials_file = "../awscredentials"
  ami_name      = format("ami-node-k8s-v%s-%s", replace("${var.version_k8s}" , "." , ""), replace(timestamp(), ":", "-"))
  instance_type = var.instance_type
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = var.username
  tags = {
          "Name" = format("node-k8s-v%s", replace("${var.version_k8s}", "." , ""))
          "App" = "kubernetes"
          "Version" = "${var.version_k8s}" 
          "Creation" = formatdate("DD-MMM-YY hh:mm:ss" , timestamp())
  }
}

build {
    name = "cluster-k8s"
    sources = [
        "source.amazon-ebs.node_k8s"
    ]

    provisioner "ansible" {
        playbook_file = "./requeriments.yaml"  
        use_proxy = false
    }


}