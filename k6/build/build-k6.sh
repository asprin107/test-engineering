#!/bin/sh

# Build k6 binary
# For linux
#docker run --rm -it -u "$(id -u):$(id -g)" -v "${PWD}:/xk6" grafana/xk6 build v0.43.1 \
#  --with github.com/grafana/xk6-output-influxdb@v0.4.0 \
#  --with github.com/grafana/xk6-output-prometheus-remote@v0.2.1

# For MacOS
docker run --rm -it -e GOOS=darwin -u "$(id -u):$(id -g)" -v "${PWD}:/xk6" grafana/xk6 build v0.43.1 \
  --with github.com/grafana/xk6-output-influxdb@v0.4.0 \
  --with github.com/grafana/xk6-output-prometheus-remote@v0.2.1
