output "db_ip" {
	value = aws_instance.mongodb_instance.private_ip
}