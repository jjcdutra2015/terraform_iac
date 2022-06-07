resource "aws_security_group" "acesso_geral" {
  name = "acesso_geral"
  description = "grupo do Dev"
  ingress{}
  egress{}
  tags = {
      Name = "acesso_geral"
  }
}