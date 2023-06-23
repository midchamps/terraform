# resource의 모음을 module이라고 함.
# 아래 source의 주소에 있는 terraform repository에 저장된 모듈을 가져와서 사용하는 것.
module "cluster" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name           = "test-aurora-db-postgres96"
  engine         = "aurora-postgresql"
  engine_version = "11.12"
  instance_class = "db.t2.micro"

  instances = {
    one = {}
    2 = {
      instance_class = "db.t2.micro"
    }
  }
  # child module에서 return 받은 output 값
  vpc_id = var.vpc_id
  # tfvars 파일에서 상속
  subnets = var.database_subnet_id

  # allowed_security_groups = ["sg-12345678"]
  # allowed_cidr_blocks = var.database_subnet_cidr_block

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
