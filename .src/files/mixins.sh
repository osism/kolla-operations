#!/bin/bash
set -x
set -o

RULES_OUT="../prometheus"
DASHBOARDS_OUT="../grafana/dashboards"

jb install

for FOLDER in $(find mixins/ -maxdepth 1 -mindepth 1 -type d); do
    for FILE in "${FOLDER}"/*.libsonnet; do
        NAME=$(basename ${FILE%%.libsonnet})
        jsonnet -J vendor -S -e 'std.manifestYamlDoc((import "'"${FILE}"'").prometheusAlerts)' > "${RULES_OUT}/${NAME}.rules"
        jsonnet -J vendor -S -e 'std.manifestYamlDoc((import "'"${FILE}"'").prometheusRules)' > "${RULES_OUT}/${NAME}.rec.rules"
	jsonnet -J vendor -m "${DASHBOARDS_OUT}/$(basename ${FOLDER})" -e '(import "'"${FILE}"'").grafanaDashboards'
    done
done
