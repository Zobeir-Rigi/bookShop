variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "dockerhub_token" {
  description = "Docker Hub personal access token"
  type        = string
  sensitive   = true
}
