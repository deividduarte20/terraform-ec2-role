output "id" {
  value = aws_instance.web.id
}

output "ami" {
  value = aws_instance.web.ami
}

output "public_ip" {
  value = aws_instance.web.public_ip
}