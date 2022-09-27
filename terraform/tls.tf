resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "node_k8s" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "keys/node-k8s.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "node_k8s" {
  key_name   = "node-k8s"
  public_key = tls_private_key.ssh.public_key_openssh
}
