module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.26.6"

  cluster_name    = local.cluster_name
  cluster_version = "1.23"    
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = [  
    "75.2.98.97/32",
    "99.83.150.238/32",
    "52.86.200.106/32",
    "52.86.201.227/32",
    "52.70.186.109/32",
    "44.236.246.186/32",
    "44.238.78.236/32",
    "86.22.229.35/32"
  ]



  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

    attach_cluster_primary_security_group = true

    # Disabling and using externally provided security groups
    create_security_group = false
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"     


      instance_types = ["t2.micro"]  

      min_size     = 2
      max_size     = 3
      desired_size = 2

      pre_bootstrap_user_data = <<-EOT
      echo 'All sorted'     
      EOT

      vpc_security_group_ids = [
        aws_security_group.node_group_one.id
      ]        
    }
  }
  tags = {  
    Name = "gbaral-eks"
    Environment = "Test and development"
    Retention = "1 Week"
    Priority = "High"
  }
}
