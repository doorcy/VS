terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "0.2.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
}

provider "kind" {}

resource "kind_cluster" "default" {
  name = "terraform-k8s-cluster"
  
  kind_config {
    kind = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
      
      extra_port_mappings {
        container_port = 30081
        host_port      = 8081
      }

      extra_mounts {
        host_path      = "${path.cwd}/data/db"
        container_path = "/var/lib/mysql-data"
      }
      extra_mounts {
        host_path      = "${path.cwd}/data/html"
        container_path = "/var/www/html-data"
      }
    }
  }
}

provider "kubernetes" {
  host                   = kind_cluster.default.endpoint
  client_certificate     = kind_cluster.default.client_certificate
  client_key             = kind_cluster.default.client_key
  cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
}