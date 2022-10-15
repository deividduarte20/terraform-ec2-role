resource "aws_instance" "web" {
  ami                  = data.aws_ami.amazon_linux.id
  instance_type        = var.inst_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile-ssm.name
  key_name             = var.inst_key

  tags = {
    Name = "DevOps"
  }
}
