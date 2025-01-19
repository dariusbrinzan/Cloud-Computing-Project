provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "configuration_server" {
  metadata {
    name = "configuration-server"
  }
}

resource "kubernetes_deployment" "product_service" {
  metadata {
    name      = "product-service"
    namespace = kubernetes_namespace.configuration_server.metadata[0].name
    labels = {
      app = "product-service"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "product-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "product-service"
        }
      }

      spec {
        container {
          name  = "product-service-ms"
          image = var.image
          image_pull_policy = "Never"

          port {
            container_port = 8004
          }

          resources {
            requests = {
              memory = var.memory_request
              cpu    = var.cpu_request
            }
            limits = {
              memory = var.memory_limit
              cpu    = var.cpu_limit
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "product_service" {
  metadata {
    name      = "product-service"
    namespace = kubernetes_namespace.configuration_server.metadata[0].name
  }

  spec {
    selector = {
      app = "product-service"
    }

    port {
      protocol    = "TCP"
      port        = 8004
      target_port = 8004
      node_port   = var.node_port
    }

    type = "NodePort"
  }
}
