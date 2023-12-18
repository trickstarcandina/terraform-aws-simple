resource "aws_vpc" "main" {
    cidr_block           = var.cidr
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "SPY${var.env}-vpc"
    }
}

resource "aws_subnet" "public_subnets" {
    vpc_id            = aws_vpc.main.id
    count             = max(length(var.public_subnets))
    cidr_block        = element(concat(var.public_subnets, [""]), count.index)
    availability_zone = element(var.azs, count.index)

    tags = {
        Name = "SPY${var.env}-public-0${count.index + 1}"
    }
}

resource "aws_subnet" "private_subnets" {
    vpc_id            = aws_vpc.main.id
    count             = max(length(var.private_subnets))
    cidr_block        = element(concat(var.private_subnets, [""]), count.index)
    availability_zone = element(var.azs, count.index)

    tags = {
        Name = "SPY${var.env}-private-0${count.index + 1}"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
}

# Elastic IP
resource "aws_eip" "nat" {
    domain                    = "vpc"

    tags = {
        Name = "SPY${var.env}-nat-eip"
    }
}

# Nat gateway
resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.nat.id
    subnet_id = element(aws_subnet.public_subnets[*].id, 0)

    tags = {
        Name = "SPY${var.env}-nat"
    }

    depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    route {
        cidr_block = "10.0.0.0/24"
        gateway_id = "local"
    }

    tags = {
        Name = "SPY${var.env}-public-rt"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "10.0.0.0/24"
        gateway_id = "local"
    }

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main.id
    }

    tags = {
        Name = "SPY${var.env}-private-rt"
    }
}

resource "aws_route_table_association" "public" {
    count          = length(var.public_subnets)
    subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
    count          = length(var.private_subnets)
    subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
    route_table_id = aws_route_table.private.id
}
