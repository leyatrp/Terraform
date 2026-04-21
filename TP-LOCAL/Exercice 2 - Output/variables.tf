variable "nginx_image" {
	type = string
	default = "nginx:latest"
}

variable "container_name" {
	type = string
	default = "nginx-terraform"
}

variable "internal_port" {
	type = number
	default = 80
}

variable "external_port" {
	type = number
	default = 8080
}
