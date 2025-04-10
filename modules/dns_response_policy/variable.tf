variable "name" {
  type        = string
  default     = "test"
  description = "Name of the resource. Provided by the client when the resource is created. "
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "managedby" {
  type        = string
  default     = "slovink"
  description = "ManagedBy, eg 'slovink'."
}

variable "repository" {
  type        = string
  default     = "https://github.com/slovink/terraform-google-dns"
  description = "Terraform current module repo"
}

variable "description" {
  type        = string
  default     = "Managed by slovink"
  description = "The description of the response policy."
}

variable "network_self_links" {
  type        = list(string)
  description = "The self links of the network to which the dns response policy needs to be applied. Note that only one response policy can be applied on a network."
  default     = []
}

#variable "google_dns_response_policy" {
#  type    = string
#  default = "google_dns_response_policy.response-policy.response_policy_name"
#}

variable "rules" {
  type = map(object({
    dns_name      = string
    rule_behavior = optional(string)
    rule_local_datas = optional(map(object({
      ttl     = string
      rrdatas = list(string)
    })))
  }))
  description = <<EOF
  This variable defines a set of rules.
  EOF
}


variable "policy_name" {
  description = "Name of the policy"
  type        = string
  default     = "default_policy"
}
