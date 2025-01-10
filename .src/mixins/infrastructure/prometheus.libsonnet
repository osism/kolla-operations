local prometheus = import "prometheus-mixin/mixin.libsonnet";

prometheus {
  _config+:: {
    // Opt-out of multi-cluster dashboards by overriding this.
    showMultiCluster: false,
  },
  prometheusRules+: {},
  prometheusAlerts+: {},
  grafanaDashboards+: {}
}
