resource "volterra_namespace" "myns" {
  name = var.namespace
}

resource "volterra_origin_pool" "webserver" {
  name                   = format("%s-op", var.project_prefix)
  namespace              = volterra_namespace.myns.name
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"
  port                   = 8080
  no_tls                 = true

  origin_servers {
    k8s_service {
      service_name = format("webserver.%s", volterra_namespace.myns.name)
      inside_network = true
      site_locator {
        site {
          name = var.appstack_site
          namespace = "system"
        }
      }
    }
  }
  healthcheck {
    name = volterra_healthcheck.hc.name
  }
}

resource "volterra_http_loadbalancer" "public" {
  name                      = format("%s-public", var.project_prefix)
  namespace                 = volterra_namespace.myns.name
  no_challenge              = true
  domains                   = [ format("mwlb.%s", var.delegated_domain) ]
  advertise_on_public_default_vip = true

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true

  https_auto_cert {
    http_redirect = true
  }

  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/"
      }
      origin_pools {
        pool {
          namespace = var.namespace
          name = volterra_origin_pool.webserver.name
        }
      }
    }
  }
}

resource "volterra_http_loadbalancer" "webserver" {
  name                      = format("%s-webserver", var.project_prefix)
  namespace                 = volterra_namespace.myns.name
  no_challenge              = true
  domains                   = [ "mwlb.mwlabs.net" ]

  http {
    dns_volterra_managed    = false
    port                    = "80"
  }

  advertise_custom {
    advertise_where {
      port = 80
      site {
        network = "SITE_NETWORK_OUTSIDE"
        ip = "94.231.81.88"
        site {
          name = var.appstack_site
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      namespace = var.namespace
      name = volterra_origin_pool.webserver.name
    }
  }
}

resource "volterra_healthcheck" "hc" {
  name      = format("%s-hc", var.project_prefix)
  namespace = volterra_namespace.myns.name

  http_health_check {
    use_origin_server_name = true
    path                   = "/"
  }
  healthy_threshold   = 1
  interval            = 15
  timeout             = 1
  unhealthy_threshold = 2

  depends_on = [ volterra_namespace.myns ]
}

output "namespace" {
  value = volterra_namespace.myns.name
}
