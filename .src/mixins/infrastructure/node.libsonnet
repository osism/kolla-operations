local node = import "node-mixin/mixin.libsonnet";

node {
  prometheusRules+: {},
  prometheusAlerts+: {},
  grafanaDashboards+: {
    # Hide unused dashboards
    'nodes-darwin.json':: super['nodes-darwin.json'],
    'nodes-aix.json':: super['nodes-aix.json']
  }
}
