provider "aws" {
  region     = "us-west-2"
  #access_key = "AKIAVRUVUD75GW4RH5RV"
  #secret_key = "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"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  #cidr = "10.0.0.0/16"
  cidr = var.vpc_cidr_block

  #azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  azs             = [var.avail_zone]
  #private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  #public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnets  = [var.subnet_cidr_block]
  public_subnet_tags  = { Name = "${var.env_prefix}-subnet-1" }

  #enable_nat_gateway = true
  #enable_vpn_gateway = true

  tags = {
    #Terraform = "true"
    #Environment = "dev"
    Name = "${var.env_prefix}-vpc"
  }
}

module "myapp-server" {
  source = "./modules/webserver"
  #vpc_id = aws_vpc.myapp-vpc.id
  vpc_id = module.vpc.vpc_id
  my_ip = var.my_ip
  env_prefix = var.env_prefix
  image_name = var.image_name
  public_key_location = var.public_key_location
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnets[0]
  #default_sg_id =
  avail_zone = var.avail_zone
  private_key_location = var.private_key_location
}


/*resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
      Name: "${var.env_prefix}-vpc"
  }
}*/

/*module "myapp-subnet" {
  source = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}*/

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

