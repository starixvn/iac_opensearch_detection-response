terraform {
  required_providers {
    opensearch = {
      source  = "lvkins/opensearch"
      version = "1.1.3"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.8.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
  backend "s3" {}
}

provider "opensearch" {
  url      = var.opensearch_api
  username = data.vault_kv_secret_v2.secrets["opensearch_cred"].data["username"]
  password = data.vault_kv_secret_v2.secrets["opensearch_cred"].data["password"]
}
