resource "aws_cloudwatch_dashboard" "main" {
    dashboard_name = "TrickstarMonitoring${var.env}"

    dashboard_body = jsonencode({
        widgets = [
            {
                type   = "metric"
                x      = 0
                y      = 0
                width  = 12
                height = 6

                properties = {
                    metrics = [
                        [
                            "AWS/EC2",
                            "CPUUtilization",
                            "AutoScalingGroupName",
                            "TrickstarAutoScalingGroup"
                        ]
                    ]
                    period = 300
                    stat   = "Average"
                    region = var.region
                    title  = "EC2 Average CPU"
                }
            },
            {
                type   = "metric"
                x      = 0
                y      = 0
                width  = 12
                height = 6

                properties = {
                    metrics = [
                        [
                            "AWS/ApplicationELB",
                            "HealthyHostCount",
                            "TargetGroup",
                            var.target_group_arn_suffix,
                            "LoadBalancer",
                            var.load_balancer_arn_suffix
                        ]
                    ]
                    period = 60
                    stat   = "Average"
                    region = var.region
                    title  = "EC2 Instance Count"
                }
            }
        ]
    })
}