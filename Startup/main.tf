terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0"
}

resource "null_resource" "start_minikube" {
  provisioner "local-exec" {
    command = "minikube start"
  }
}
