provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "user_service" {
  metadata {
    name      = "user-service"
    namespace = "configuration-server"
    labels = {
      app = "user-service"
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = "user-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "user-service"
        }
      }

      spec {
        container {
          name  = "user-service-ms"
          image = var.image
          image_pull_policy = "Never"

          port {
            container_port = 8002
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

resource "kubernetes_service" "user_service" {
  metadata {
    name      = "user-service"
    namespace = "configuration-server"
  }

  spec {
    selector = {
      app = "user-service"
    }

    port {
      protocol    = "TCP"
      port        = 8002
      target_port = 8002
      node_port   = var.node_port
    }

    type = "NodePort"
  }
}
