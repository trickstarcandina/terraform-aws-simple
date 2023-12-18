resource "aws_security_group" "load_balancer" {
    name        = "SPY${var.env}Alb-sg"
    description = "Security group for bastion host server"
    vpc_id      = var.vpc_id

    ingress {
        description = "Allow HTTP for webserver"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow HTTPS for webserver"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Environment = var.env
    }
}

resource "aws_lb" "main" {
    name               = "SPY${var.env}-alb"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.load_balancer.id]
    subnets            = var.public_subnets

    enable_deletion_protection = false

    tags = {
        Environment = var.env
    }
}

resource "aws_lb_target_group" "main" {
    name     = "SPY${var.env}-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "main" {
    load_balancer_arn = aws_lb.main.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.main.arn
    }

    tags = {
        Environment = var.env
    }
}
