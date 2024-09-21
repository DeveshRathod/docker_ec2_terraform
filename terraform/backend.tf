terraform {
  backend "s3" {
    bucket         = "shopease-main"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}
