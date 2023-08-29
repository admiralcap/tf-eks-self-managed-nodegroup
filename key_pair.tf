resource "tls_private_key" "tls-private_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "private_key" {
  filename = "./id_rsa.pem"
  content = tls_private_key.tls-private_key.private_key_pem
  file_permission = "0600"
  depends_on = [ tls_private_key.tls-private_key ]
}
resource "local_file" "public_key_openssh" {
  filename = "./id_rsa.pub"
  content = tls_private_key.tls-private_key.public_key_openssh
  file_permission = "0644"
  depends_on = [ tls_private_key.tls-private_key ]
}
resource "local_file" "public_key_pem" {
  filename = "./id_rsa.pem.pub"
  content = tls_private_key.tls-private_key.public_key_pem
  file_permission = "0644"
  depends_on = [ tls_private_key.tls-private_key ]
}

resource "aws_key_pair" "aws-keypair" {
  key_name   = var.aws-keypair-name
  public_key = tls_private_key.tls-private_key.public_key_openssh
  depends_on = [ tls_private_key.tls-private_key ]
}