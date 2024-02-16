# ---------------------------------------------
# Terraform configuration
# ---------------------------------------------
terraform {
  required_version = ">=1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ---------------------------------------------
# Provider
# ---------------------------------------------
provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

# ---------------------------------------------
# Variables
# ---------------------------------------------
variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_address" {
  type = string
}

variable "private_1a_address" {
  type = string
}

variable "private_1c_address" {
  type = string
}

variable "policy_app_runner_ecs_access_arn" {
  type = string
}

variable "app_repository" {
  type = string
}

variable "app_name" {
  type = string
}

variable "app_env" {
  type = string
}

variable "app_key" {
  type = string
}

variable "app_debug" {
  type = string
}

variable "app_url" {
  type = string
}

variable "log_channel" {
  type = string
}

variable "log_deprecations_channel" {
  type = string
}

variable "log_level" {
  type = string
}

variable "db_engine" {
  type = string
}

variable "db_version" {
  type = string
}

variable "db_full_version" {
  type = string
}

variable "db_instance_type" {
  type = string
}

variable "db_connection" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_database" {
  type = string
}

variable "db_username" {
  type = string
}

variable "broadcast_driver" {
  type = string
}

variable "cache_driver" {
  type = string
}

variable "filesystem_disk" {
  type = string
}

variable "queue_connection" {
  type = string
}

variable "session_driver" {
  type = string
}

variable "session_lifetime" {
  type = number
}
