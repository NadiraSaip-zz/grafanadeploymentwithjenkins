resource "kubernetes_secret" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "${var.namespace}"
  }
  data {
    admin-username = "admin"
    admin-password = "${var.password}"
  }
  type = "Opaque"
}

