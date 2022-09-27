resource "aws_security_group" "allow_access_node_k8s_wk" {
  name        = "allow_access_node_k8s_wk"
  description = "Allow Node Workload Traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description      = "Allow kubelet API inbound traffic"
    from_port        = 10250
    to_port          = 10250
    protocol         = "tcp"
    security_groups      = [aws_security_group.allow_access_node_k8s_cp.id]
    self             = true
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "NodePort Services"
    from_port        = 30000
    to_port          = 32767
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
    Name = "SG_node_k8s_wk"
  }
}