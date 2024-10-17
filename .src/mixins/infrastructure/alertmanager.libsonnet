local alertmanager = import "alertmanager-mixin/mixin.libsonnet";

alertmanager {
  prometheusRules+: {},
  prometheusAlerts+: {},
  grafanaDashboards+: {}
}
