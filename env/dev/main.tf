module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-west-2"
  chave = "iac-dev"
  grupo_seguranca = "acesso_dev"
  descricao_seguranca = "grupo do Dev"
}

output "IP" {
  value = module.aws-dev.IP_publico
}