provider "aws" {
  region     = "us-west-2"
  #access_key = "AKIAVRUVUD75GW4RH5RV"
  #secret_key = "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"
}

variable "cidr_blocks" {
    description = "cidr blocks and name tags for vpc and subnets"
    type = list(object({
      cidr_block = string
      name = string
    }))
}

variable avail_zone {}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  #cidr_block = "10.0.0.0/16"
  tags = {
      #Name: var.environment
      Name: var.cidr_blocks[0].name
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = var.avail_zone
  tags = {
      Name: var.cidr_blocks[1].name
  }
}


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

