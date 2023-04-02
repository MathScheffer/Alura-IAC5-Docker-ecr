terraform {
  backend "s3" {
    bucket = "terraform-backend-curso-alura"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

