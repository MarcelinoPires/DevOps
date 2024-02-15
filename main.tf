provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "devlab" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  key_name      = "labweb"
  
  security_groups = ["allow_ssh_http"]
  user_data = file("setup.sh")
  
  tags = {
    Name = "labweb-tf"
  }
 
#  provisioner "remote-exec" {
#    inline = [
#      "sudo su -",
#      "apt-get update",
#      "apt-get upgrade -y",
#      "apt-get install apache2 -y",
#      "git clone https://github.com/denilsonbonatti/mundo-invertido.git",
#      "cp -r mundo-invertido/* /var/www/html/"
#    ]
#  }
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
