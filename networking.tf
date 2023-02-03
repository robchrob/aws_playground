resource "aws_vpc" "sandbox-vpc" {
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
  cidr_block           = "10.0.0.0/16"
}

resource "aws_subnet" "sandbox-subnet_public" {
  vpc_id                  = aws_vpc.sandbox-vpc.id
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = "true"
  cidr_block              = "10.0.1.0/24"
}

resource "aws_internet_gateway" "sandbox-net_gateway" {
  vpc_id = aws_vpc.sandbox-vpc.id
}

resource "aws_route_table" "sandbox-route" {
  vpc_id = aws_vpc.sandbox-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sandbox-net_gateway.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.sandbox-net_gateway.id
  }
}

resource "aws_route_table_association" "sandbox-table-assoc" {
  subnet_id      = aws_subnet.sandbox-subnet_public.id
  route_table_id = aws_route_table.sandbox-route.id
}
