resource "kubernetes_deployment" "grafana_core" {
  metadata {
    name      = "grafana-core"
    namespace = "tools"
    labels {
      app       = "grafana"
      component = "core"
    }
  }
  spec {
    replicas = 1
    template {
      metadata {
        labels {
          app       = "grafana"
          component = "core"
        }
      }
      spec {
        volume {
          name = "grafana-persistent-storage"
        }
        container {
          name  = "grafana-core"
          image = "grafana/grafana:4.2.0"
          env {
            name  = "GF_AUTH_BASIC_ENABLED"
            value = "true"
          }
          env {
            name = "GF_SECURITY_ADMIN_USER"
            value_from {
              secret_key_ref {
                name = "grafana"
                key  = "admin-username"
              }
            }
          }
          env {
            name = "GF_SECURITY_ADMIN_PASSWORD"
            value_from {
              secret_key_ref {
                name = "grafana"
                key  = "admin-password"
              }
            }
          }
          env {
            name  = "GF_AUTH_ANONYMOUS_ENABLED"
            value = "false"
          }
          resources {
            limits {
              cpu    = "100m"
              memory = "100Mi"
            }
            requests {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
          volume_mount {
            name       = "grafana-persistent-storage"
            mount_path = "/var/lib/grafana"
          }
          readiness_probe {
            http_get {
              path = "/login"
              port = "3000"
            }
          }
          image_pull_policy = "IfNotPresent"
        }
      }
    }
  }
}

