provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "config_server_namespace" {
  metadata {
    name = "configuration-server"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [metadata]
  }
}

resource "kubernetes_deployment" "config_server" {
  metadata {
    name      = "configuration-server"
    namespace = kubernetes_namespace.config_server_namespace.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "configuration-server"
      }
    }

    template {
      metadata {
        labels = {
          app = "configuration-server"
        }
      }

      spec {
        container {
          name  = "configuration-server"
          image = "configuration-server-2:latest"

          port {
            container_port = 8888
          }

          resources {
            requests = {
              memory = "512Mi"
              cpu    = "500m"
            }
            limits = {
              memory = "1Gi"
              cpu    = "1"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "config_server" {
  metadata {
    name      = "configuration-server"
    namespace = kubernetes_namespace.config_server_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "configuration-server"
    }

    port {
      port        = 8888
      target_port = 8888
    }

    type = "ClusterIP"
  }
}
