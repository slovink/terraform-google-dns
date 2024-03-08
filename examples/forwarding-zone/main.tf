provider "google" {
  project = "testing-gcp-ops"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### vpc module call.
#####==============================================================================

module "vpc" {
  source                                    = "git::https://github.com/slovink/terraform-google-network.git?ref=v1.0.0"
  name                                      = "ops"
  environment                               = "test"
  routing_mode                              = "REGIONAL"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
}
#####==============================================================================
##### dns-forwarding-zone module call.
#####==============================================================================
module "dns_forwarding_zone" {
  source                             = "../../"
  type                               = "forwarding"
  name                               = "ops-test"
  environment                        = "forwarding"
  visibility                         = "private"
  domain                             = var.domain
  labels                             = var.labels
  private_visibility_config_networks = [module.vpc.self_link]
  target_name_server_addresses = [
    {
      ipv4_address    = "8.8.8.8",
      forwarding_path = "default"
    },
    {
      ipv4_address    = "8.8.4.4",
      forwarding_path = "default"
    }
  ]
}
