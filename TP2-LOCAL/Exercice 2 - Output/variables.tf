variable "instance_type" {
  description = "Le type d'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Le nom de l'instance EC2"
  type        = string
  default     = "nginx-server"
}

variable "bucket_name" {
  description = "Le nom du bucket S3"
  type        = string
  default     = "my-bucket"
}

variable "default_port" {
  description = "Le port par défaut pour le groupe de sécurité"
  type        = number
  default     = 80
}