module "aws-prod" {
  source          = "../../infra"
  instancia       = "t2.micro"
  regiao_aws      = "us-west-2"
  chave           = "iac-prod"
  grupo_seguranca = "PROD"
  minimo          = 1
  maximo          = 10
  nomeGrupo       = "PROD"
}
