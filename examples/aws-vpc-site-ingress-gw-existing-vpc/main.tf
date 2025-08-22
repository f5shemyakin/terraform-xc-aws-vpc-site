provider "volterra" {
  api_p12_file = var.xc_api_p12_file
  url          = var.xc_api_url
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "aws_vpc" {
  source  = "f5devcentral/aws-vpc-site-networking/xc"
  version = "0.0.6"

  name          = "aws-example-ingress-gw-vpc"
  vpc_cidr      = "172.10.0.0/16"
  az_names      = ["us-west-2a"]
  local_subnets = ["172.10.1.0/24"]
}

module "aws_vpc_site" {
  source = "../.."

  site_name              = "aws-example-ingress-gw"
  aws_region             = "us-west-2"
  site_type              = "ingress_gw"
  master_nodes_az_names  = ["us-west-2a"]
  create_aws_vpc         = false
  vpc_id                 = module.aws_vpc.vpc_id
  existing_local_subnets = module.aws_vpc.local_subnet_ids

  custom_security_group = {
    outside_security_group_id = module.aws_vpc.outside_security_group_id
  }

  aws_cloud_credentials_name = module.aws_cloud_credentials.name
  block_all_services         = false

  tags = {
    key1 = "value1"
    key2 = "value2"
  }

  depends_on = [
    module.aws_cloud_credentials,
  ]
}

module "aws_cloud_credentials" {
  source  = "f5devcentral/aws-cloud-credentials/xc"
  version = "0.0.4"

  tags = {
    key1 = "value1"
    key2 = "value2"
  }

  name           = "aws-tf-test-creds"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
}
