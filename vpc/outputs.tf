# main.tf의 return value 라고 생각하면 됨.
# Cli 화면에서 해당 값들을 확인하거나
# Parent module에서 해당 값을 이용하는 방법으로 사용할 수 있음.

output "vpc_id" {
  value = module.vpc.vpc_id
}

# output "public_subnet_id" {
#   value = module.vpc.public.id
# }

# output "private_subnet_id" {
#   value = module.vpc.private.id
# }

# output "database_subnet_id" {
#   description = "database subnet id 리스트"
#   value       = module.vpc.database.id
# }

output "database_subnets" {
  value = module.vpc.database_subnets
}
