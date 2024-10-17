#!/usr/local/bin/python3

import os
import subprocess

dashboards_out_prefix = "../grafana/dashboards"
rules_out_prefix = "../prometheus"

print("Installing dependencies...")
try:
    out = subprocess.run(["/usr/local/bin/jb", "install"], capture_output=True)
except subprocess.SubprocessError as e:
    print(e.stderr)
    raise e
print(out.stdout.decode())
print(out.stderr.decode())

for path, _, filenames in os.walk("mixins"):
    for file in filenames:
        dashboards_out = os.path.join(
            dashboards_out_prefix, *os.path.normpath(path).split(os.sep)[1:]
        )
        if file.endswith(".libsonnet"):
            name = file.removesuffix(".libsonnet")
            print("Processing mixin " + name)
            print("Creating dashboard(s)...")
            os.makedirs(dashboards_out, exist_ok=True)
            try:
                subprocess.run(
                    [
                        "jsonnet",
                        "-J",
                        "vendor",
                        "-m",
                        dashboards_out,
                        "-e",
                        '(import "' + os.path.join(path, file) + '").grafanaDashboards',
                    ]
                )
            except subprocess.SubprocessError as e:
                print(e.stderr)
                raise e
            for kind, suffix in [
                ("prometheusAlerts", ".rules"),
                ("prometheusRules", ".rec.rules"),
            ]:
                print("Creating " + kind + "...")
                prometheus_out = os.path.join(rules_out_prefix, name + suffix)
                with open(prometheus_out, "w") as f:
                    try:
                        subprocess.run(
                            [
                                "jsonnet",
                                "-J",
                                "vendor",
                                "-S",
                                "-e",
                                'std.manifestYamlDoc((import "'
                                + os.path.join(path, file)
                                + '").'
                                + kind
                                + ")",
                            ],
                            stdout=f,
                        )
                    except subprocess.SubprocessError as e:
                        print(e.stderr)
                        raise e
                print(prometheus_out)
