local ceph = import "ceph-mixin/mixin.libsonnet";

ceph {
  prometheusRules+: {},
  prometheusAlerts+: {},
  grafanaDashboards+: {}
}
