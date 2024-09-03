terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }

    github = {
      source = "integrations/github"
      version = "~> 6.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.32.0"
    } 

  }
}

data "azurerm_resource_group" "azure_rg" {
  name = var.azure_resource_group_name
}

data "azurerm_container_registry" "acr" {
  name = var.azure_registry_name
  resource_group_name = data.azurerm_resource_group.azure_rg.name
}


data "azurerm_kubernetes_cluster" "cluster" {
  name = var.azure_cluster_name
  resource_group_name = data.azurerm_resource_group.azure_rg.name
}

resource "github_repository" "target_repo" {
  name        = var.github_repo_name

  visibility = "public"

  template {
    owner                = var.github_template_owner
    repository           = var.github_template_repo
    include_all_branches = true
  }
}


module "gitops_secret" {
  source = "./modules/gitops_secret"

  providers = {
    github = github
  }

  github_repo_name = var.github_repo_name
  ACR_USERNAME = data.azurerm_container_registry.acr.admin_username
  ACR_PASSWORD = data.azurerm_container_registry.acr.admin_password
  AZURE_URL = data.azurerm_container_registry.acr.login_server

  depends_on = [ github_repository.target_repo ]
}

resource "kubernetes_namespace" "target" {
  metadata {
    name = var.dest_namespace
  }
}