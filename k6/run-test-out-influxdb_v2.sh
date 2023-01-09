#!/bin/sh

export K6_INFLUXDB_USERNAME=my-user
export K6_INFLUXDB_PASSWORD=my-password
export K6_INFLUXDB_INSECURE=false
export K6_INFLUXDB_PUSH_INTERVAL='1s'
export K6_INFLUXDB_CONCURRENT_WRITES='4'

export K6_INFLUXDB_ORGANIZATION='org'
export K6_INFLUXDB_BUCKET='test'
export K6_INFLUXDB_ADDR='http://localhost:8087'
export K6_INFLUXDB_TOKEN=

k6 run -o xk6-influxdb=http://localhost:8087 test.js