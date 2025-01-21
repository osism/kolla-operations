local blackbox = import "blackbox-exporter-mixin/mixin.libsonnet";

blackbox {
  prometheusRules+: {},
  prometheusAlerts+: {},
  grafanaDashboards+: {}
}
