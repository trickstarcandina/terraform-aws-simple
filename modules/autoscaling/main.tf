resource "aws_autoscaling_group" "main" {
    name                      = "SPY${var.env}-asg"
    max_size                  = 3
    min_size                  = 2
    health_check_grace_period = 300
    desired_capacity          = 2
    health_check_type         = "ELB"
    vpc_zone_identifier       = var.vpc_zone_identifier

    launch_template {
        id      = var.launch_template_id
        version = "$Latest"
    }
}

resource "aws_autoscaling_policy" "main" {
    autoscaling_group_name = aws_autoscaling_group.main.name
    name                   = "SPY${var.env}-asp"
    policy_type            = "TargetTrackingScaling"

    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 70.0
    }
}

resource "aws_autoscaling_attachment" "main" {
    autoscaling_group_name = aws_autoscaling_group.main.id
    lb_target_group_arn    = var.lb_target_group_arn
}