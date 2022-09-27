


resource "aws_security_group" "allow_access_node_k8s_cp" {
  name        = "allow_access_node_k8s_cp"
  description = "Allow Node Control Plane Traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Allow kubelet API inbound traffic"
    from_port        = 10250
    to_port          = 10250
    protocol         = "tcp"
    self             = true
   
  }

  ingress {
    description      = "Allow kube-scheduler inbound"
    from_port        = 10259
    to_port          = 10259
    protocol         = "tcp"
    self             = true
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "kube-controller-manager inbound"
    from_port        = 10257
    to_port          = 10257
    protocol         = "tcp"
    self             = true
     cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow Kubernetes API server traffic"
    from_port        = 6443
    to_port          = 6443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

    ingress {
    description      = "etcd server client API"
    from_port        = 2379
    to_port          = 2380
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "SG_node_k8s_cp"
  }
}