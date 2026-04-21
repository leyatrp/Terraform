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
  
  networks_advanced {
  name = docker_network.nginx_network.name
}

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

resource "docker_network" "nginx_network" {
  name = "nginx-network"
}

resource "docker_image" "curl" {
  name = "appropriate/curl"
}

resource "docker_container" "client" {
	count = var.client_count
	name  = "client-${count.index}"
	image = docker_image.curl.image_id

  networks_advanced {
    name = docker_network.nginx_network.name
  }

  command = [
    "sh",
    "-c",
    "curl http://${var.container_name}:${var.internal_port} && sleep 3600"
  ]

  depends_on = [docker_container.nginx]
}
