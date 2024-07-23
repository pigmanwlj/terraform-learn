provider "aws" {
  region     = "us-west-2"
  #access_key = "AKIAVRUVUD75GW4RH5RV"
  #secret_key = "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"
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
      Name: "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "myapp-server" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.myapp-vpc.id
  my_ip = var.my_ip
  env_prefix = var.env_prefix
  image_name = var.image_name
  public_key_location = var.public_key_location
  instance_type = var.instance_type
  subnet_id = module.myapp-subnet.subnet.id
  #default_sg_id =
  avail_zone = var.avail_zone
  private_key_location = var.private_key_location
}


/*resource "aws_route_table" "myapp_route_table" {
  vpc_id = aws_vpc.myapp-vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
      Name: "${var.env_prefix}-rtb"
  }
}*/

/*resource "aws_route_table_association" "a-rtb-subnet" {
  subnet_id = aws_subnet.myapp-subnet-1.id
  route_table_id = aws_route_table.myapp_route_table.id
}*/

/*variable "cidr_blocks" {
    description = "cidr blocks and name tags for vpc and subnets"
    type = list(object({
      cidr_block = string
      name = string
    }))
}*/

/*variable "cidr_blocks" {
    description = "cidr block for vpc and subnets"
    type = list(string)
}*/

/*variable "subnet_cidr_block" {
    description = "subnet cidr block"
    default = "10.0.10.0/24"
    type = string
}*/

/*variable "vpc_cidr_block" {
    description = "vpc cidr block"
}

variable "environment" {
    description = "deployment environment"
}*/

/*output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}*/

/*data "aws_vpc" "existing_vpc" {
  default = true  
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.64.0/20"
  availability_zone = "us-west-2a"
}*/

