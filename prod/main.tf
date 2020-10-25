provider "datadog" {
  api_key = var.dd_api_key
  app_key = var.dd_app_key
}

resource "datadog_monitor" "cpumonitor_prod" {
  name = "CPU Monitor for Production"
  type = "metric alert"
  message = "CPU usage alert"
  query = "avg(last_1m):avg:system.cpu.system{*} by {host} > 70"

  tags = ["env:prod"]
}