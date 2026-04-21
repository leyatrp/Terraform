terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.5.0"
    }
  }
}

provider "docker" {
  host = "tcp://localhost:2375"
}

resource "docker_image" "nginx" {
  name         = var.nginx_image
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id
  ports {
    internal = var.internal_port
    external = var.external_port
  }
  
   provisioner "local-exec" {
    command = "curl.exe -s http://localhost:${var.external_port} | findstr Welcome"
  }
}

output "nginx_container_id" {
	value = docker_container.nginx.id
}

