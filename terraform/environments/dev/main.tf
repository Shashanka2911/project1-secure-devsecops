# 1. Network
module "vpc" {
    source = "../../modules/vpc"

    vpc_name           = "devsecops-vpc-dev"
    vpc_cidr           = "10.0.0.0/16"
    availability_zones = ["ap-south-1a", "ap-south-1b"]
    private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# 2. Container Registry
module "ecr" {
    source = "../../modules/ecr"

    repository_name = "devsecops-product-api"
}
# 3. Kubernetes Cluster
module "eks" {
    source = "../../modules/eks"

    cluster_name    = "devsecops-cluster"

# We pass the outputs from the VPC module directly into the EKS module
    vpc_id          = module.vpc.vpc_id
    private_subnets = module.vpc.private_subnets
}