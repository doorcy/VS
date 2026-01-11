resource "kubernetes_service" "matomo" {
  metadata { name = "matomo" }
  spec {
    selector = { app = "matomo" }
    type     = "NodePort"
    port {
      port        = 80
      target_port = 80
      node_port   = 30081
    }
  }
}

resource "kubernetes_deployment" "matomo" {
  metadata {
    name = "matomo"
    labels = { app = "matomo" }
  }
  
  depends_on = [kubernetes_deployment.mariadb]

  spec {
    replicas = 1
    selector { match_labels = { app = "matomo" } }
    template {
      metadata { labels = { app = "matomo" } }
      spec {
        container {
          image = "doorsy/matomo-custom:latest" 
          name  = "matomo"

          env {
            name  = "MATOMO_DATABASE_HOST"
            value = "mariadb"
          }
          env {
            name  = "MATOMO_DATABASE_USERNAME"
            value = var.db_user
          }
          env {
            name  = "MATOMO_DATABASE_PASSWORD"
            value = var.db_password
          }
          env {
            name  = "MATOMO_DATABASE_DBNAME"
            value = var.db_name
          }

          volume_mount {
            name       = "matomo-storage"
            mount_path = "/var/www/html"
          }
        }
        volume {
          name = "matomo-storage"
          host_path {
            path = "/var/www/html-data"
            type = "DirectoryOrCreate"
          }
        }
      }
    }
  }
}