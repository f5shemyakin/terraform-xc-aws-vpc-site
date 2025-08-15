output "site_name" {
  description = "Name of the configured AWS VPC Site."
  value       = module.aws_vpc_site.name
}

output "site_id" {
  description = "ID of the configured AWS VPC Site."
  value       = module.aws_vpc_site.id
}

output "master_public_ip_address" {
  description = "Ip address of the master node."
  value       = try(module.aws_vpc_site.apply_tf_output_map.master_public_ip_address, null)
}

output "ssh_private_key" {
  description = "AWS VPC Site generated private key."
  value       = module.aws_vpc_site.ssh_private_key_openssh
  sensitive   = true
}

output "ssh_public_key" {
  description = "AWS VPC Site public key."
  value       = module.aws_vpc_site.ssh_public_key
}

output "vpc_id" {
  value       = module.aws_vpc_site.vpc_id
  description = "The ID of the VPC."
}

output "local_subnet_ids" {
  value       = module.aws_vpc_site.local_subnet_ids
  description = "List of local subnet IDs."
}
