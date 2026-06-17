terraform {
  backend "s3" {
    bucket       = "vault-terraform-state-570729420924"
    key          = "state/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
