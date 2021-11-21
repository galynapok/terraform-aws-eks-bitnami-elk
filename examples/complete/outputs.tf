output "kibana_lb" {
  description = "Load balancer for kibana"
  value       = module.elasticsearch.kibana_lb
}
