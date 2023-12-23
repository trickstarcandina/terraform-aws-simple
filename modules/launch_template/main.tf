# Tạo security group cho bastion host
resource "aws_security_group" "bastion_host" {
    name        = "SPY${var.env}BastionHost-sg"
    description = "Security group for bastion host"
    vpc_id      = var.vpc_id

    ingress {
        description = "Allow SSH inbound"
        from_port   = 22
        to_port     = 22
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

# Tạo launch_template cho bastion host
resource "aws_launch_template" "bastion_host" {
    name          = "SPY${var.env}BastionHost-template"
    description   = "Launch template server bastion host"
    image_id      = var.image_id
    instance_type = var.instance_type
    key_name      = var.keypair

    network_interfaces {
        subnet_id                   = element(var.public_subnet_ids, 0)
        security_groups             = [aws_security_group.bastion_host.id]
        associate_public_ip_address = true
    }

    tags = {
        Environment = var.env
    }
}

## Tạo instance cho bastion host
resource "aws_instance" "bastion_host" {
    launch_template {
        id      = aws_launch_template.bastion_host.id
        version = "$Latest"
    }

    tags = {
        Name = "SPY${var.env}BastionHost"
    }
}

# Tạo security group cho webserver instance
resource "aws_security_group" "webserver" {
    name        = "SPY${var.env}Webserver-sg"
    description = "Security group for webserver instance"
    vpc_id      = var.vpc_id

    ingress {
        description     = "Allow SSH inbound traffic"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        security_groups = [aws_security_group.bastion_host.id]
    }

    ingress {
        description     = "Allow HTTP for webserver"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = [var.security_group_alb]
    }

    ingress {
        description     = "Allow HTTPS for webserver"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        security_groups = [var.security_group_alb]
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

# Tạo launch_template cho webserver instance
resource "aws_launch_template" "webserver" {
    name          = "SPY${var.env}Webserver-template"
    description   = "Launch template webserver instance."
    image_id      = var.image_id
    instance_type = var.instance_type
    key_name      = var.keypair

    network_interfaces {
        security_groups             = [aws_security_group.webserver.id]
        associate_public_ip_address = false
    }

    user_data = filebase64("user-data.sh")

    tags = {
        Environment = var.env
    }
}
