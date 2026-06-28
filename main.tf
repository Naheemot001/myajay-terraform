resource "aws_instance" "myajay_app" {
  ami             = "ami-06445ac85e0d277a9"
  instance_type   = "t2.micro"
  key_name        = "Ajay_devs"
  security_groups = [aws_security_group.myajay_app_sg.name]
  tags = {
    Name = "myajay-app"

  }
  user_data = file("userdata.sh")

}