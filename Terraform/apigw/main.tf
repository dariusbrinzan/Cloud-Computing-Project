provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "apigw_namespace" {
  metadata {
    name = "apigw"
  }
}

resource "kubernetes_deployment" "apigw" {
  metadata {
    name      = "apigw-service"
    namespace = kubernetes_namespace.apigw_namespace.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "apigw-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "apigw-service"
        }
      }

      spec {
        container {
          image = "apigw-image-1:latest"
          name  = "apigw-service"

          port {
            container_port = 8001
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "apigw" {
  metadata {
    name      = "apigw-service"
    namespace = kubernetes_namespace.apigw_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "apigw-service"
    }

    port {
      port        = 8001
      target_port = 8001
    }

    type = "NodePort"
  }
}
