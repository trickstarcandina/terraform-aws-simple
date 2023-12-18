# Khởi tạo security group cho Database
resource "aws_security_group" "database" {
    name        = "SPY${var.env}Database-sg"
    description = "Security group for bastion host server"
    vpc_id      = var.vpc_id

    ingress {
        description     = "Allow SSH inbound traffic"
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = [var.security_group_webserver]
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

resource "aws_db_subnet_group" "private" {
    name       = "SPY-${lower(var.env)}-private-group"
    subnet_ids = var.private_subnets

    tags = {
        Environment = var.env
    }
}

resource "aws_db_instance" "main" {
    db_name                = "SPY${var.env}Mysql"
    db_subnet_group_name   = aws_db_subnet_group.private.name
    publicly_accessible    = false
    allocated_storage      = 10
    engine                 = "mysql"
    engine_version         = "8.0"
    instance_class         = "db.t3.micro"
    username               = "admin"
    password               = "password"
    parameter_group_name   = "default.mysql8.0"
    skip_final_snapshot    = true
    vpc_security_group_ids = [aws_security_group.database.id]
    multi_az               = true
}