resource "kubernetes_service" "grafana" {
  metadata {
    name      = "grafana"
    namespace = "tools"
    labels {
      app       = "grafana"
      component = "core"
    }
  }
  spec {
    port {
      protocol    = "TCP"
      port        = 80
      target_port = "3000"
    }
    selector {
      app       = "grafana"
      component = "core"
    }
    type = "LoadBalancer"
  }
}

