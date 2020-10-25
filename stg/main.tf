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
      name = "Staging_for_tf4dd"
    }
  }
}

provider "datadog" {
  api_key = var.dd_api_key
  app_key = var.dd_app_key
}

resource "datadog_monitor" "cpumonitor_stg" {
  name = "CPU Monitor for Staging"
  type = "metric alert"
  message = "CPU usage alert"
  query = "avg(last_1m):avg:system.cpu.system{*} by {host} > 70"

  tags = ["env:stg"]
}