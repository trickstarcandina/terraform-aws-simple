output "webserver" {
    description = "ID of the VPC"
    value       = aws_launch_template.webserver.id
}

output "security_group_webserver" {
    description = ""
    value       = aws_security_group.webserver.id
}
