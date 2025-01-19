variable "replicas" {
  description = "Number of replicas for the deployment"
  type        = number
  default     = 1
}

variable "image" {
  description = "Container image for the deployment"
  type        = string
  default     = "user-image-test-1:latest"
}

variable "memory_request" {
  description = "Memory requested for the container"
  type        = string
  default     = "512Mi"
}

variable "cpu_request" {
  description = "CPU requested for the container"
  type        = string
  default     = "500m"
}

variable "memory_limit" {
  description = "Memory limit for the container"
  type        = string
  default     = "1Gi"
}

variable "cpu_limit" {
  description = "CPU limit for the container"
  type        = string
  default     = "1"
}

variable "node_port" {
  description = "NodePort for the service"
  type        = number
  default     = 30082
}
