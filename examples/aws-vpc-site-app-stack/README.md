# App Stack AWS VPC Site with single AZ for F5 XC Cloud

The following example will create an App Stack (Voltstack Cluster) AWS VPC Site in F5 XC Cloud with single AZ and a security group. This site type is suitable for running Kubernetes workloads.

```hcl
module "aws_vpc_site_app_stack" {
  source                = "../.."

  site_name             = "aws-example-app-stack"
  aws_region            = "us-west-2"
  site_type             = "app_stack"
  master_nodes_az_names = ["us-west-2a"]
  vpc_cidr              = "172.10.0.0/16"
  local_subnets         = ["172.10.1.0/24"]

  aws_cloud_credentials_name = "your_cloud_credentials_name"
  block_all_services         = false

  # Kubernetes cluster configuration
  k8s_cluster = {
    name = "app-stack-k8s"
  }

  # Use default storage
  default_storage = true

  tags = {
    key1 = "value1"
    key2 = "value2"
  }

  depends_on = [ 
    module.aws-cloud-credentials
  ]
}
```

## Features

This App Stack site type supports:

- **Kubernetes Clusters**: Deploy and manage Kubernetes workloads
- **Storage Classes**: Configure persistent storage for applications  
- **DC Cluster Groups**: Connect to distributed cloud cluster groups
- **Global Networks**: Connect to global virtual networks
- **Firewall Policies**: Apply enhanced firewall and network policies
- **Forward Proxy**: Configure forward proxy policies
- **Static Routes**: Configure custom routing for applications

## Variables

Key variables specific to the App Stack site type:

- `k8s_cluster`: Kubernetes cluster configuration object
- `default_storage`: Use default storage class (boolean)
- `storage_class_list`: List of custom storage class configurations
- `dc_cluster_group`: DC cluster group configuration

## Requirements

| Name                                                                      | Version    |
| ------------------------------------------------------------------------- | ---------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0     |
| <a name="requirement_aws"></a> [aws](#requirement\_aws)                   | >= 4.65.0  |
| <a name="requirement_volterra"></a> [volterra](#requirement\_volterra)    | >= 0.11.26 |

## Providers

| Name                                                             | Version    |
| ---------------------------------------------------------------- | ---------- |
| <a name="provider_volterra"></a> [volterra](#provider\_volterra) | >= 0.11.26 |
| <a name="provider_aws"></a> [aws](#provider\_aws)                | >= 4.65.0  |
