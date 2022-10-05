terraform {
  backend "remote" {
    organization = "gbaral-dev"
    hostname = "app.terraform.io"
 
    workspaces {
      name = "eksdemo"
    }
  }
}