terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-state-s3-giancarlopetrini"
    dynamodb_table = "dynamodb-terraform-state-lock"
    region         = "us-east-1"
    key            = "terraform.tfstate"
  }
}
