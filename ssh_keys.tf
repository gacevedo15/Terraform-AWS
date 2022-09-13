resource "aws_key_pair" "actrafer" {
  key_name   = "actrafer.pem"
  public_key = "${file("pem/actrafer.pem.pub")}"
}