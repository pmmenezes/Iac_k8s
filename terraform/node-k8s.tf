data "aws_ami" "node_k8s" {
  most_recent = true

 
  filter {
    name   = "tag:App"
    values = ["kubernetes"]
  }
  filter {
    name   = "tag:Version"
    values = [var.version_k8s]
  }

  owners = ["self"] 
}

resource "aws_instance" "node_k8s_wk" {
  count = var.numero_nodes_wk
  ami           = data.aws_ami.node_k8s.id
  instance_type = var.instance_type
  key_name = aws_key_pair.node_k8s.key_name
  root_block_device {
    volume_type = "gp3"
    volume_size = 30
  }
  
  vpc_security_group_ids = [ 
      "${aws_security_group.allow_access_ssh_k8s.id}", 
      "${aws_security_group.allow_access_node_k8s_wk.id}"
      ]


  tags = {
          "Name" = format("node0%s-wk", count.index )
          "App" = "kubernetes"
          "Version" = "${var.version_k8s}" 
          "Role" = "workload"
  }
}

resource "aws_instance" "node_k8s_cp" {
  count = var.numero_nodes_cp
  ami           = data.aws_ami.node_k8s.id
  instance_type = var.instance_type
  root_block_device {
    volume_type = "gp3"
    volume_size = 30
  }
 
  key_name = aws_key_pair.node_k8s.key_name
  vpc_security_group_ids = [ 
      "${aws_security_group.allow_access_ssh_k8s.id}", 
      "${aws_security_group.allow_access_node_k8s_cp.id}"
        ]


  tags = {
          "Name" = format("node0%s-cp", count.index )
          "App" = "kubernetes"
          "Version" = "${var.version_k8s}" 
          "Role" = "control-plane"
  }
}

