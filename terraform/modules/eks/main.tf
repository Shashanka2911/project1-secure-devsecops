module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  # Networking
  # EKS control plane and worker nodes use these subnets
  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  # Allow kubectl access from your laptop
  cluster_endpoint_public_access = true

  # Managed Node Groups
  eks_managed_node_groups = {
    devsecops_nodes = {
      min_size     = 2
      max_size     = 4
      desired_size = 3

      # Free-tier eligible instance type
      instance_types = ["t3.micro"]
      capacity_type  = "ON_DEMAND"

      # Amazon Linux 2023 for EKS
      ami_type = "AL2023_x86_64_STANDARD"
    }
  }

  # Allow Terraform creator to administer the cluster
  enable_cluster_creator_admin_permissions = true
}