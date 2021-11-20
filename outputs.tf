output "helm_release" {
  value = helm_release.elasticsearch
}

output "kibana_lb" {
  value = try(data.aws_elb.elasticsearch-kibana[0].dns_name, "")
}
