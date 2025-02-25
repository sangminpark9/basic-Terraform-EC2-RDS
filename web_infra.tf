resource "aws_key_pair" "web_admin" {
  key_name = "web_admin"
  public_key = file("${pathexpand("~/.ssh/web_admin.pub")}")
}

resource "aws_security_group" "ssh" {
  name = "allow_ssh_from_all"
  description = "Allow SSH port from all"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_security_group" "default" {
  name = "default"
}

resource "aws_instance" "web" {
  ami = "ami-0a93a08544874b3b7" # amzn2-ami-hvm-2.0.20200207.1-x86_64-gp2
  instance_type = "t2.micro"
  key_name = aws_key_pair.web_admin.key_name
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    data.aws_security_group.default.id
  ]
}

resource "aws_db_instance" "web_db" {
  allocated_storage = 20
  engine = "mysql"
  engine_version = "8.0.34"
  instance_class = "db.t3.micro"
  username = "admin"
  password = "00000000"
  skip_final_snapshot = true
}
