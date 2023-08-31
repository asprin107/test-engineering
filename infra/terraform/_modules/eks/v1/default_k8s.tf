# Fargate logging Configuration. See https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/fargate-logging.html
resource "kubernetes_namespace_v1" "fargate_logging" {
  metadata {
    name = "aws-observability"
    labels = {
      aws-observability = "enabled"
    }
  }
}

resource "kubernetes_config_map_v1" "fargate_logging" {
  metadata {
    name      = "aws-logging"
    namespace = kubernetes_namespace_v1.fargate_logging.metadata[0].name
  }
  data = {
    flb_log_cw     = "false" # Set to true to ship Fluent Bit process logs to CloudWatch.
    "filters.conf" = templatefile("${path.module}/resources/fluentbit/cloudwatch/filters.conf.tftpl", {})
    "output.conf" = templatefile("${path.module}/resources/fluentbit/cloudwatch/output.conf.tftpl", {
      aws_region = data.aws_region.current.name
    })
    "parsers.conf" = templatefile("${path.module}/resources/fluentbit/cloudwatch/parsers.conf.tftpl", {})
  }
}