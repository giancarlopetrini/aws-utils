provider "aws" {
  region  = "us-east-1"
  profile = "tf-admin"
}

resource "aws_instance" "firstec2" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"

  tags {
    Name = "FirstEC2TF!"
  }
}

resource "aws_s3_bucket" "terraform-state" {
  bucket        = "terraform-state-s3-giancarlopetrini"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags {
    Name = "terraform-state-bucket-giancarlopetrini"
  }
}

resource "aws_s3_bucket_policy" "terraform-state" {
  bucket = "${aws_s3_bucket.terraform-state.id}"

  policy = "${file("s3-state-iam-policy.json")}"
}

resource "aws_dynamodb_table" "dynamodb-terraform-state" {
  name           = "dynamodb-terraform-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "dynamoDB-terraform-state-lock-table"
  }
}
