local prometheus = import "prometheus-mixin/mixin.libsonnet";

prometheus {
  prometheusRules+: {},
  prometheusAlerts+: {},
  grafanaDashboards+: {}
}
