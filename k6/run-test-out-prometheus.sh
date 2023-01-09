#!/bin/sh

export K6_PROMETHEUS_RW_SERVER_URL='http://localhost:9090/api/v1/write'
export K6_PROMETHEUS_RW_USERNAME=my-user
export K6_PROMETHEUS_RW_PASSWORD=my-password
export K6_PROMETHEUS_RW_INSECURE_SKIP_TLS_VERIFY=true
export K6_PROMETHEUS_RW_PUSH_INTERVAL='5s'
export K6_PROMETHEUS_RW_TREND_AS_NATIVE_HISTOGRAM=true
export K6_PROMETHEUS_RW_TREND_STATS='avg,p(90),p(99),min,max'
export K6_PROMETHEUS_RW_STALE_MARKERS=true

k6 run -o xk6-prometheus-rw test.js