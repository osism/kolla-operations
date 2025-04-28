local rabbitmq = import "rabbitmq-mixin/mixin.libsonnet";

rabbitmq {
  prometheusRules+: {},
  prometheusAlerts+: {},
  grafanaDashboards+: {}
}
