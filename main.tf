provider "aws" {
  region = "us-west-2"
}

# Підключаємо модуль для S3 та DynamoDB
module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = "terraform-state-bucket-nata" 
  table_name  = "terraform-locks"
}

# Підключаємо модуль для VPC
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_name           = "vpc"
}

# Підключаємо модуль для ECR
module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = "lesson-5-ecr"
  scan_on_push = true
}

# Підключаємо модуль для eks
module "eks" {
  source          = "./modules/eks"          
  cluster_name    = "eks-cluster-lesson-7"
  subnet_ids      = module.vpc.public_subnets # Використовуємо підмережі з модуля VPC
  instance_type   = "t3.small"
  desired_size    = 1
  max_size        = 2
  min_size        = 1
}