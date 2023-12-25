provider "aws" {
    region              = var.aws_region
    allowed_account_ids = [var.aws_allowed_account_id]
    access_key          = var.aws_access_key
    secret_key          = var.aws_secret_key
}

module "networks" {
    source          = "../../modules/networks"
    env             = var.env
    cidr            = var.network_cidr
    azs             = var.network_azs
    public_subnets  = var.network_public_subnets
    private_subnets = var.network_private_subnets
}

module "load_balancer" {
    source         = "../../modules/load_balancer"
    env            = var.env
    vpc_id         = module.networks.vpc_id
    public_subnets = module.networks.public_subnets
}

module "launch_template" {
    source             = "../../modules/launch_template"
    env                = var.env
    vpc_id             = module.networks.vpc_id
    keypair            = var.keypair
    security_group_alb = module.load_balancer.security_group_alb
    public_subnet_ids  = module.networks.public_subnets
}

module "autoscaling" {
    source              = "../../modules/autoscaling"
    env                 = var.env
    launch_template_id  = module.launch_template.webserver
    vpc_zone_identifier = module.networks.private_subnets
    lb_target_group_arn = module.load_balancer.target_group_arn
}

module "database" {
    source                   = "../../modules/database"
    env                      = var.env
    vpc_id                   = module.networks.vpc_id
    private_subnets          = module.networks.private_subnets
    availability_zone        = element(var.network_azs, 0)
    security_group_webserver = module.launch_template.security_group_webserver
}

module "cache" {
    source                     = "../../modules/cache"
    vpc_id                     = module.networks.vpc_id
    env                        = var.env
    node_type                  = "cache.t3.micro"
    parameter_group_name       = "default.redis7"
    automatic_failover_enabled = true
    num_cache_clusters         = 2
    multi_az_enabled           = true
    subnet_ids                 = module.networks.private_subnets
    security_group_webserver   = module.launch_template.security_group_webserver
}


module "monitoring" {
    source                   = "../../modules/monitoring"
    env                      = var.env
    region                   = var.aws_region
    target_group_arn_suffix  = module.load_balancer.target_group_arn_suffix
    load_balancer_arn_suffix = module.load_balancer.load_balancer_arn_suffix
}
