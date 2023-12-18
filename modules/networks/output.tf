output "vpc_id" {
    description = "ID of the VPC"
    value       = aws_vpc.main.id
}

output "public_subnets" {
    description = "ID of the VPC"
    value       = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
    description = "ID of the VPC"
    value       = aws_subnet.private_subnets[*].id
}
