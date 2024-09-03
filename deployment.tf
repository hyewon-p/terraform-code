resource "kubernetes_manifest" "deployment_backend_java" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "name" = var.app_name
      "namespace" = var.dest_namespace
    }
    "spec" = {
      "replicas" = 2
      "selector" = {
        "matchLabels" = {
          "app" = var.app_name
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = var.app_name
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "${var.azure_registry_name}.azurecr.io/backend-java:${var.tag}"
              "name" = var.app_name
              "ports" = [
                {
                  "containerPort" = 8080
                },
              ]
            },
          ]
        }
      }
    }
  }

}