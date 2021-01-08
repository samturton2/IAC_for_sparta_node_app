output "vpc_id" {
	value = aws_vpc.vpc.id
}

output "pub_sub" {
	value = aws_subnet.public_subnet.id
}

output "priv_sub" {
	value = aws_subnet.private_subnet.id
}