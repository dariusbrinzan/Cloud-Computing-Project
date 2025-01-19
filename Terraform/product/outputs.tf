output "product_service_url" {
  description = "The URL to access the product-service"
  value       = "http://localhost:${kubernetes_service.product_service.spec.0.ports.0.node_port}"
}
