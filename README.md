<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ingress"></a> [ingress](#module\_ingress) | dabble-of-devops-bioanalyze/eks-bitnami-nginx-ingress/aws | >= 0.1.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.elasticsearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [helm_release.elasticsearch](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.cert-manager](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [null_resource.helm_dirs](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_elb.elasticsearch-kibana](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb) | data source |
| [aws_elb.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/elb) | data source |
| [aws_route53_zone.elasticsearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [kubernetes_service.elasticsearch-kibana](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |
| [kubernetes_service.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/service) | data source |

## usage: |-
  For a complete example, see [examples/complete](examples/complete).
  For automated tests of the complete example using [bats](https://github.com/bats-core/bats-core) and [Terratest](https://github.com/gruntwork-io/terratest)
  (which tests and deploys the example on AWS), see [test](test).
  ```hcl
        module "elasticsearch" {
        source = "../.."       
        persistence_enabled = false
        data_replicas = 1
        master_replicas = 1
        coordinating_replicas = 1
        kibana_service_type = "LoadBalancer"
        enable_ssl    = false
        } 
```      
## Example usage
examples: |-
  Here is an example of using this module:
  - [`examples/complete`](https://github.com/dabble-of-devops-biodeploy/terraform-aws-eks-bitnami-elk/) 
  - complete example of using this module


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_route53_record_name"></a> [aws\_route53\_record\_name](#input\_aws\_route53\_record\_name) | Record name to add to aws\_route\_53. Must be a valid subdomain - www,app,etc | `string` | `"kibana"` | no |
| <a name="input_aws_route53_zone_name"></a> [aws\_route53\_zone\_name](#input\_aws\_route53\_zone\_name) | Name of the zone to add records. Do not forget the trailing '.' - 'test.com.' | `string` | `"bioanalyzedev.com."` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_coordinating_replicas"></a> [coordinating\_replicas](#input\_coordinating\_replicas) | n/a | `number` | `2` | no |
| <a name="input_coordinating_storage_size"></a> [coordinating\_storage\_size](#input\_coordinating\_storage\_size) | n/a | `string` | `"8Gi"` | no |
| <a name="input_data_replicas"></a> [data\_replicas](#input\_data\_replicas) | n/a | `number` | `2` | no |
| <a name="input_data_storage_size"></a> [data\_storage\_size](#input\_data\_storage\_size) | n/a | `string` | `"8Gi"` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enable_ssl"></a> [enable\_ssl](#input\_enable\_ssl) | n/a | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_helm_release_chart"></a> [helm\_release\_chart](#input\_helm\_release\_chart) | n/a | `string` | `"elasticsearch"` | no |
| <a name="input_helm_release_create_namespace"></a> [helm\_release\_create\_namespace](#input\_helm\_release\_create\_namespace) | n/a | `bool` | `true` | no |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | n/a | `string` | `"elasticsearch"` | no |
| <a name="input_helm_release_namespace"></a> [helm\_release\_namespace](#input\_helm\_release\_namespace) | n/a | `string` | `"elk"` | no |
| <a name="input_helm_release_repository"></a> [helm\_release\_repository](#input\_helm\_release\_repository) | n/a | `string` | `"https://charts.bitnami.com/bitnami"` | no |
| <a name="input_helm_release_values_dir"></a> [helm\_release\_values\_dir](#input\_helm\_release\_values\_dir) | Directory to put rendered values template files or additional keys. Should be helm\_charts/{helm\_release\_name} | `string` | `"helm_charts"` | no |
| <a name="input_helm_release_version"></a> [helm\_release\_version](#input\_helm\_release\_version) | n/a | `string` | `""` | no |
| <a name="input_helm_release_wait"></a> [helm\_release\_wait](#input\_helm\_release\_wait) | name             = var.airflow\_release\_name repository       = "https://charts.bitnami.com/bitnami" chart            = "airflow" version          = "11.0.8" namespace        = var.airflow\_namespace create\_namespace = true wait             = false values = [file("helm\_charts/airflow/values.yaml")] | `bool` | `true` | no |
| <a name="input_helm_values_file"></a> [helm\_values\_file](#input\_helm\_values\_file) | n/a | `string` | `"elk-values.yaml"` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_ingress_class"></a> [ingress\_class](#input\_ingress\_class) | n/a | `string` | `"nginx"` | no |
| <a name="input_ingress_helm_release_name"></a> [ingress\_helm\_release\_name](#input\_ingress\_helm\_release\_name) | n/a | `string` | `"nginx"` | no |
| <a name="input_ingress_helm_release_ns"></a> [ingress\_helm\_release\_ns](#input\_ingress\_helm\_release\_ns) | n/a | `string` | `"default"` | no |
| <a name="input_kibana_enabled"></a> [kibana\_enabled](#input\_kibana\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_kibana_service_type"></a> [kibana\_service\_type](#input\_kibana\_service\_type) | n/a | `string` | `"ClusterIP"` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_letsencrypt_email"></a> [letsencrypt\_email](#input\_letsencrypt\_email) | Email to use for https setup. Not needed unless enable\_ssl | `string` | `"hello@gmail.com"` | no |
| <a name="input_master_replicas"></a> [master\_replicas](#input\_master\_replicas) | n/a | `number` | `3` | no |
| <a name="input_master_storage_size"></a> [master\_storage\_size](#input\_master\_storage\_size) | n/a | `string` | `"8Gi"` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_persistence_enabled"></a> [persistence\_enabled](#input\_persistence\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-1"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_release"></a> [helm\_release](#output\_helm\_release) | n/a |
| <a name="output_kibana_lb"></a> [kibana\_lb](#output\_kibana\_lb) | n/a |
<!-- END_TF_DOCS -->