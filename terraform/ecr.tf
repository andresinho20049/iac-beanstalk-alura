resource "aws_ecr_repository" "docker_repository" {
  name = var.ecr_repository_name
}