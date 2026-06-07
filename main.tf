resource "aws_instance" "myajay_app" {
  ami           = "ami-06445ac85e0d277a9"
  instance_type = "t3.micro"
  key_name      = "Ajay_devs"
  tags = {
    Name = "myajay-app"
  }
}