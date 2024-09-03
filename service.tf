resource "kubernetes_manifest" "service_backend_java" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "name" = var.app_name
      "namespace" = var.dest_namespace
    }
    "spec" = {
      "ports" = [
        {
          "port" = 80
          "protocol" = "TCP"
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = var.app_name
      }
    }
  }
}