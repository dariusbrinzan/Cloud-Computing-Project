output "user_service_url" {
  description = "The URL to access the user-service"
  value       = "http://localhost:${kubernetes_service.user_service.spec.0.ports.0.node_port}"
}
