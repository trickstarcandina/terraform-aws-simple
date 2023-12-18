output "target_group_arn" {
    description = ""
    value       = aws_lb_target_group.main.arn
}

output "target_group_arn_suffix" {
    description = ""
    value       = aws_lb_target_group.main.arn_suffix
}

output "target_group_name" {
    description = ""
    value       = aws_lb_target_group.main.name
}

output "load_balancer_arn_suffix" {
    description = ""
    value       = aws_lb.main.arn_suffix
}

output "load_balancer_name" {
    description = ""
    value       = aws_lb.main.name
}

output "security_group_alb" {
    description = ""
    value       = aws_security_group.load_balancer.id
}