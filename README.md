# chaos-engineering

## k6

### Outputs
#### Types
* influxdb-grafana : Test worker's metric are saved into influxdb and can be visualized with grafana.
* prometheus-grafana : Test worker's metric are saved into prometheus and can be visualized with grafana.

#### How to run?
  Go to `./k6/outputs` directory.

Run using docker compose.
```shell
docker-compose up -d
```

## Sample Test Target

### Hotel Booking Service (Spring)
#### How to run?
Go to `./sampleTestTarget` directory.

Run using docker compose.
```shell
docker-compose up -d
```

Run as a java application.
You have to installed java and maven before run.
```shell
mvn jetty:run
```