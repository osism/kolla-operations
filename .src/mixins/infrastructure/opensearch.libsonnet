local opensearch = import "opensearch-mixin/mixin.libsonnet";

opensearch {
  _config+:: {
    enableLokiLogs: false,
  },
  prometheusRules+: {},
  prometheusAlerts+: {},
  grafanaDashboards+: {}
}
