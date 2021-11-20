##################################################
# Variables
# This file has various groupings of variables
##################################################

##################################################
# AWS
##################################################

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

##################################################
# AWS EKS - Kubernetes Cluster
# Most of the time we will just pass in a provider
##################################################

# variable "eks_cluster_id" {
#   description = "EKS Cluster Id - This cluster must exist."
#   type        = string
# }

# variable "eks_cluster_oidc_issuer_url" {
#   description = "URL to the oidc issuer. The cluster must have been created with :   oidc_provider_enabled = true"
#   type        = string
# }

##################################################
# Helm Release Variables
# corresponds to input to resource "helm_release"
##################################################

# name             = var.airflow_release_name
# repository       = "https://charts.bitnami.com/bitnami"
# chart            = "airflow"
# version          = "11.0.8"
# namespace        = var.airflow_namespace
# create_namespace = true
# wait             = false
# values = [file("helm_charts/airflow/values.yaml")]
variable "helm_release_wait" {
  type    = bool
  default = true
}

variable "helm_release_create_namespace" {
  type    = bool
  default = true
}

variable "helm_release_chart" {
  type = string
  default = "elasticsearch"
}

variable "helm_release_namespace" {
  type = string
  default = "elk"
}

variable "helm_release_values_dir" {
  type        = string
  description = "Directory to put rendered values template files or additional keys. Should be helm_charts/{helm_release_name}"
  default     = "helm_charts"
}

variable "helm_values_file" {
  type = string
  default = "elk-values.yaml"
  
}

variable "master_replicas" {
  type = number
  default = 3
}

variable "data_replicas" {
  type = number
  default = 2
}

variable "coordinating_replicas" {
  type = number
  default = 2
}

variable "persistence_enabled" {
  type = bool
  default = true
}

variable "master_storage_size" {
  type = string
  default = "8Gi"
}

variable "coordinating_storage_size" {
  type = string
  default = "8Gi"
}

variable "data_storage_size" {
  type = string
  default = "8Gi"
}

variable "helm_release_name" {
  type = string
  default = "elasticsearch"
}

variable "helm_release_repository" {
  type = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "helm_release_version" {
  type    = string
  default = ""
}

variable "kibana_enabled" {
  type = bool
  default = true
}

variable "enable_ssl" {
  type = bool
  default = true
}
 
variable "ingress_helm_release_name" {
  type = string
  default = "nginx"
} 

variable "letsencrypt_email" {
  type        = string
  description = "Email to use for https setup. Not needed unless enable_ssl"
  default     = "hello@gmail.com"
}


variable "aws_route53_zone_name" {
  type        = string
  description = "Name of the zone to add records. Do not forget the trailing '.' - 'test.com.'"
  default     = "bioanalyzedev.com."
}

variable "aws_route53_record_name" {
  type        = string
  description = "Record name to add to aws_route_53. Must be a valid subdomain - www,app,etc"
  default     = "kibana"
}


variable "ingress_class" {
  type = string
  default = "nginx"
}

variable "ingress_namespace" {
  type = string 
  default = "default"
}

variable "kibana_service_type" {
  type = string
  default = "ClusterIP"
}

variable "install_ingress" {
  type = bool
  default = true
}