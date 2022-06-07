module "aws-prod" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-west-2"
  chave = "iac-prod"
  grupo_seguranca = "acesso_prod"
  descricao_seguranca = "grupo de Prod"
}

output "IP" {
  value = module.aws-prod.IP_publico
}