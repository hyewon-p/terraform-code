
variable "dest_namespace" {
  default = "hello"
  type = string
}

variable "app_name" {
  type = string
}

variable "azure_resource_group_name" {
  type = string
}

variable "azure_cluster_name" {
  type = string
}

variable "azure_subscription" {
  type = string
}

variable "azure_registry_name" {
  type = string
}

variable "github_repo_name" {
  type = string
}

variable "github_org" {
  type = string
}

variable "github_token" {
  type = string
}

variable "github_template_owner" {
  type = string
}

variable "github_template_repo" {
  type = string
}

variable "tag" {
  type = string
}

variable "dns_prefix" {
  type = string
}

