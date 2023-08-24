resource "tls_private_key" "rsa_4096" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name_value
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name_value
}

resource "aws_instance" "public_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.deployer.key_name

  tags = {
    Name = "public_instance"
  }
}