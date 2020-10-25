terraform {
  required_version = "0.13.5"

  required_providers {
    datadog = {
      source = "datadog/datadog"
    }
  }

  backend "remote" {
    organization = "keishi-sandbox"

    workspaces {
      name = "Production_for_tf4dd"
    }
  }
}

provider "datadog" {
  api_key = var.dd_api_key
  app_key = var.dd_app_key
}

resource "datadog_monitor" "cpumonitor_prod" {
  name = "CPU Monitor for Production"
  type = "metric alert"
  message = "CPU usage alert"
  query = "avg(last_1m):avg:system.cpu.system{*} by {host} > 80"

  tags = ["env:prod"]
}

resource "datadog_monitor" "hostcheck_prod" {
  name = "Host Check for Production"
  type = "service check"
  message = "host alert"
  query = "\"datadog.agent.up\".over(\"env:prod\").last(2).count_by_status()"

  tags = ["env:prod"]
}