resource "null_resource" "helm_dirs" {
  provisioner "local-exec" {
    command = "mkdir -p ${var.helm_release_values_dir}"
  }
}

resource "kubectl_manifest" "cert-manager" {
  provider = kubectl
  count = var.enable_ssl && var.kibana_enabled == true ? 1 : 0
  yaml_body = file("${path.module}/helm_charts/ingress/cert-manager.yaml")
  override_namespace = var.ingress_helm_release_ns
}


module "ingress" {
  count                   = var.enable_ssl && var.kibana_enabled == true ? 1 : 0
  source                  = "dabble-of-devops-bioanalyze/eks-bitnami-nginx-ingress/aws"
  version                 = ">= 0.1.0"
  letsencrypt_email       = var.letsencrypt_email
  helm_release_values_dir = var.helm_release_values_dir
  helm_release_name       = var.ingress_helm_release_name
  helm_release_namespace  = var.ingress_helm_release_ns
}

data "kubernetes_service" "ingress" {
  count = var.enable_ssl && var.kibana_enabled == true ? 1 : 0
  depends_on = [
    module.ingress
  ]
  metadata {
    name = "${var.ingress_helm_release_name}-ingress-nginx-ingress-controller"
  }
}
#wait for service
data "aws_elb" "ingress" {
  count = var.enable_ssl && var.kibana_enabled == true ? 1 : 0
  depends_on = [
    data.kubernetes_service.ingress
  ]
  name = split("-", data.kubernetes_service.ingress[0].status.0.load_balancer.0.ingress.0.hostname)[0]
}


resource "helm_release" "elk" {
  depends_on = [
    module.ingress
  ]
  name             = var.helm_release_name
  repository       = var.helm_release_repository
  chart            = var.helm_release_chart
  version          = var.helm_release_version
  namespace        = var.helm_release_namespace
  create_namespace = var.helm_release_create_namespace
  wait             = var.helm_release_wait

  values = [try(file(var.helm_values_file), "")]
  set {
    name  = "master.replicas"
    value = var.master_replicas
  }
   set {
    name  = "master.persistence.enabled"
    value = var.persistence_enabled
  }
  set {
    name = "master.persistence.size"
    value = var.master_storage_size
  }
  set {
    name  = "coordinating.replicas"
    value = var.coordinating_replicas
  }
   set {
    name  = "coordinating.persistence.enabled"
    value = var.persistence_enabled
  }
  set {
    name = "coordinating.persistence.size"
    value = var.coordinating_storage_size 
  }
  set {
    name  = "data.replicas"
    value = var.data_replicas
  }
   set {
    name  = "data.persistence.enabled"
    value = var.persistence_enabled
  }
  set {
    name  = "data.persistence.size"
    value = var.data_storage_size
  }
  set {
    name  = "global.kibanaEnabled"
    value = var.kibana_enabled
  }
  set {
    name  =  "kibana.ingress.enabled"
    value = var.enable_ssl
  }
  set {
    name = "kibana.ingress.hostname"
    value = regex("\\w+\\.\\w+\\.\\w+", format("%s.%s", var.aws_route53_record_name, var.aws_route53_zone_name)) 
  }  
  set {
    name = "kibana.ingress.annotations.kubernetes\\.io\\/ingress\\.class"
    value = var.ingress_class
  }
  set {
    name = "kibana.ingress.annotations.cert-manager\\.io\\/cluster-issuer"
    value = format("%s-letsencrypt", var.ingress_helm_release_name)
  }

}

#########################################################################
# helm_release_values_service_type == ClusterIP and var.enable_ssl = true
#########################################################################


data "aws_route53_zone" "elk" {
  count = var.enable_ssl == true ? 1 : 0
  name  = var.aws_route53_zone_name
}

resource "aws_route53_record" "elk" {
  count = var.enable_ssl ? 1 : 0
  depends_on = [
    module.ingress,
    helm_release.elk,
  ]
  zone_id = data.aws_route53_zone.elk[0].zone_id
  name    = var.aws_route53_record_name
  type    = "A"
  alias {
    name                   = data.aws_elb.ingress[0].dns_name
    zone_id                = data.aws_elb.ingress[0].zone_id
    evaluate_target_health = true
  }
}
     