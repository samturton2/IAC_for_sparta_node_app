output "priv_sg" {
	value = aws_security_group.sg-priv.id
}

output "pub_sg" {
	value = aws_security_group.sg-pub.id
}