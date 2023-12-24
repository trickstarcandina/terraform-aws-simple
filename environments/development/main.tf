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

module "launch_template" {
    source  = "../../modules/launch_template"
    env     = var.env
    vpc_id  = module.networks.vpc_id
    keypair = var.keypair
}

module "load_balancer" {
    source         = "../../modules/load_balancer"
    env            = var.env
    vpc_id         = module.networks.vpc_id
    public_subnets = module.networks.public_subnet
}

module "autoscaling" {
    source              = "../../modules/autoscaling"
    env                 = var.env
    launch_template_id  = module.launch_template.webserver_instance_id
    vpc_zone_identifier = module.networks.public_subnet
    lb_target_group_arn = module.load_balancer.target_group_arn
}

module "monitoring" {
    source                   = "../../modules/monitoring"
    env                      = var.env
    region                   = var.aws_region
    target_group_arn_suffix  = module.load_balancer.target_group_arn_suffix
    load_balancer_arn_suffix = module.load_balancer.load_balancer_arn_suffix
}