module "elasticsearch" {
  source = "../.."       
  persistence_enabled = false
  data_replicas = 1
  master_replicas = 1
  coordinating_replicas = 1
  kibana_service_type = "LoadBalancer"
  enable_ssl    = false
} 