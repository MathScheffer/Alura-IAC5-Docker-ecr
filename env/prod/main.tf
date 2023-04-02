module "prod" {
  source = "../../infra"

  nome_repositorio = "prod"
  cargoIam = "producao"
  ambiente = "producao"
  
}

output "IP_alb" {
  value = module.prod.IP
}


