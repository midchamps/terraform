terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

# vpc module 선언
module "vpc" {
  # Local source
  source                     = "./vpc"
  vpc_cidr_block             = "10.0.0.0/16"
  public_subnet_cidr_block   = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  private_subnet_cidr_block  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  database_subnet_cidr_block = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}

# module "postgres" {

#   source             = "./database"
#   depends_on         = [module.vpc]
#   vpc_id             = module.vpc.vpc_id
#   database_subnet_id = module.vpc.database_subnet_id
#   # private subnet id 2개 필요..
# }
