# Terraform (HCL) — syntax sampler
terraform {
  required_version = ">= 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "env" {
  type        = string
  description = "Deployment environment"
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "env must be dev|staging|prod"
  }
}

locals {
  tags = {
    app = "preview"
    env = var.env
  }
  cidr_blocks = [for n in range(2) : "10.${n}.0.0/16"]
}

provider "aws" {
  region = var.env == "prod" ? "us-east-1" : "us-west-2"
}

resource "aws_s3_bucket" "assets" {
  bucket = "preview-${var.env}-${random_id.suffix.hex}"
  tags   = local.tags

  lifecycle {
    prevent_destroy = var.env == "prod"
  }
}

resource "random_id" "suffix" {
  byte_length = 2
}

module "network" {
  source = "./modules/network"

  vpc_cidr = local.cidr_blocks[0]
  subnets  = [for i in range(3) : "10.0.${i}.0/24"]
}

data "aws_iam_policy_document" "example" {
  statement {
    sid     = "AllowList"
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    resources = [
      aws_s3_bucket.assets.arn,
    ]
    condition {
      test     = "StringEquals"
      variable = "s3:prefix"
      values   = ["public/"]
    }
  }
}

output "bucket_name" {
  value       = aws_s3_bucket.assets.bucket
  description = <<-EOT
  Multiline heredoc example with interpolation: ${var.env}
  EOT
}
