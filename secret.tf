resource "kubernetes_secret" "grafana-secrets" {
  metadata {
    name      = "grafana-secrets"
    namespace = "${var.namespace}"
  }
  data {
    admin-username = "admin"
    admin-password = "${var.password}"
  }
  type = "Opaque"
}

