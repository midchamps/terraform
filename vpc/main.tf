# 특정 리소스에 접근 가능
# 주어진 소스인 "aws_availbility_zone" 를 읽고 az export 한다.
# 같은 테라폼 모듈내에서 만든 이름으로 해당 리소스를 사용한다.
data "aws_availability_zones" "az" {}

# resource "aws_eip" "natgateway" {
#   count = 2

#   vpc = true
# }

module "vpc" {
  # aws.vpc 리소스를 생성하는 모듈.
  source = "terraform-aws-modules/vpc/aws"
  # 버전을 명시하지 않을 경우, 자동으로 최신버전을 가져옵니다.
  # version = "5.0.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  # seoul region에서 사용할 수 있는 az 3개 사용
  azs              = slice(data.aws_availability_zones.az.names, 0, 3)
  private_subnets  = var.private_subnet_cidr_block
  public_subnets   = var.public_subnet_cidr_block
  database_subnets = var.database_subnet_cidr_block

  # Single NAT Gateway 설정
  # https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.4?utm_content=documentLink&utm_medium=Visual+Studio+Code&utm_source=terraform-ls
  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_vpn_gateway     = true
  reuse_nat_ips          = false
  one_nat_gateway_per_az = false

  # RDS 인스턴스에 대한 프라이빗 엑세스 ( 개발용 )
  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  # DB는 외부에 노출되지않도록 igw를 연결하지않습니다. 필요하다면 bastion host를 통해 통신하도록합니다.
  create_database_internet_gateway_route = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  # # # NACL 규칙 생성 (기본 네트워크 ACL 생성)
  # manage_default_network_acl = true


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
