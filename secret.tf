resource "kubernetes_secret" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "tools"
  }
  data {
    admin-username = "admin"
    data           = [97, 100, 109, 105, 110]
    admin-password = "admin"
  }
  type = "Opaque"
}

