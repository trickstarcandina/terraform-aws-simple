# create security group for Redis
resource "aws_security_group" "cache" {
    name        = "SPY${var.env}Cache-sg"
    description = "security group for bastion host server"
    vpc_id      = var.vpc_id

    ingress {
        description = "Allow SSH inbound traffic"
        from_port   = 6379
        to_port     = 6379
        protocol    = "tcp"
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

resource "aws_elasticache_subnet_group" "main" {
    name       = "SPY${var.env}-subnet-group"
    subnet_ids = var.subnet_ids
}

resource "aws_elasticache_replication_group" "main" {
    multi_az_enabled           = var.multi_az_enabled
    automatic_failover_enabled = var.automatic_failover_enabled
    replication_group_id       = "aws-${lower(var.env)}-replication-group"
    description                = "SPY${lower(var.env)} redis description"
    node_type                  = var.node_type
    num_cache_clusters         = var.num_cache_clusters
    parameter_group_name       = var.parameter_group_name
    port                       = 6379
    subnet_group_name          = aws_elasticache_subnet_group.main.name
    security_group_ids         = [aws_security_group.cache.id]
}