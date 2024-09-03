terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "~> 6.0"
    }
  }
}

data "github_repository" "target_repo" {
  name = var.github_repo_name
}

resource "github_actions_secret" "ACR_USERNAME" {
  repository = data.github_repository.target_repo.name
  secret_name = "ACR_USERNAME"
  plaintext_value = var.ACR_USERNAME
}

resource "github_actions_secret" "ACR_PASSWORD" {
  repository = data.github_repository.target_repo.name
  secret_name = "ACR_PASSWORD"
  plaintext_value = var.ACR_PASSWORD
}

resource "github_actions_secret" "AZURE_URL" {
  repository = data.github_repository.target_repo.name
  secret_name = "AZURE_URL"
  plaintext_value = var.AZURE_URL
}