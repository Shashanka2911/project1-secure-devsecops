resource "aws_ecr_repository" "app_repo" {
    name                 = var.repository_name
    image_tag_mutability = "MUTABLE"
    force_delete         = true

# DevSecOps Feature: Automatic vulnerability scanning
    image_scanning_configuration {
    scan_on_push = true
    }
}