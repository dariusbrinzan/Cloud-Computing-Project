output "apigw_service_url" {
  value = "http://<MINIKUBE_IP>:${kubernetes_service.apigw.spec[0].ports[0].node_port}"
}
