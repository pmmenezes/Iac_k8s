terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29.0"
    }
     tls = {
      source = "hashicorp/tls"
      version = "4.0.2"
    }
  }
}

provider "aws" {
  # Configuration options
  region                   = "us-east-1"
  shared_credentials_files = ["../awscredentials"]
  profile                  = "default"
 }


provider "tls" {
  # Configuration options
}