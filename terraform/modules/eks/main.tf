module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"

    cluster_name    = var.cluster_name
    cluster_version = "1.30"

# Networking: EKS needs to know where to place the control plane and nodes
    vpc_id     = var.vpc_id
    subnet_ids = var.private_subnets

# Enable public access to the API server so we can use kubectl from your laptop
    cluster_endpoint_public_access = true

# Managed Node Groups: Where your FastAPI pods will actually run
    eks_managed_node_groups = {
    devsecops_nodes = {
        min_size     = 1
        max_size     = 3
        desired_size = 2

        # CHANGED: Replaced t3.medium with a Free-Tier eligible instance
        instance_types = ["t3.micro"] 
        capacity_type  = "ON_DEMAND"
        
        # Explicitly added for EKS 1.30 support
        ami_type       = "AL2023_x86_64_STANDARD"
    }
    }

# Allow the Terraform creator to manage the cluster
    enable_cluster_creator_admin_permissions = true
}