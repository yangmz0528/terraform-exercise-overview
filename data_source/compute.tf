resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
}

resource "aws_s3_bucket" "pulic_read_bucket" {
  bucket = "my-public-read-bucket"
}