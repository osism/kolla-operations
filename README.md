# kolla-operations

Repository for Grafana dashboards and Prometheus alerting rules.
For use with the Prometheus exporters from Kolla.

## Usage

While it is possible to directly place `.rules` files into the `prometheus/` folder  and grafana dashboards into `grafana/dashboards` or a subfolder thereof, use of [monitoring-mixins](https://monitoring.mixins.dev) is encouraged.

### Build the jsonnet container

Build the `mixin` container to manage mixins

```
podman build -t mixins .src
```

### Building mixins

[jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler) is used to fetch mixins and their dependencies from upstream.

* Install mixin dependencies

  ```
  podman run -it -v .:/srv localhost/mixins:latest jb install
  ```

* Build alerts, rules and dashboards
  ```
  podman run -it -v .:/srv localhost/mixins:latest
  ```

* Check all changes into git, including the generated alerts, rules and dashboards

### Adding new mixins

* Add any new upstream mixins to `.src/jsonnetfile.json
* Add a local libsonnet for any new mixins in `.src/mixins/$DASHBOARDSUBFOLDER/$NAME.libsonnet
* Apply any [customizations](https://monitoring.mixins.dev/#customising-the-mixin) to the local `$NAME.libsonnet`
* [Build mixins](#building-mixins) 
* Check all changes into git, including the `.src/jsonnetfile.lock.json`

### Updating mixins

* Update the jsonnet-bundler dependencies in `.src/jsonnetfile.lock.json

  ```
  podman run -it -v .:/srv localhost/mixins:latest jb update
  ```

* Check all changes into git, including the `.src/jsonnetfile.lock.json`
