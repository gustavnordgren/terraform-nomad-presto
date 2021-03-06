# Nomad
variable "nomad_datacenters" {
  type        = list(string)
  description = "Nomad data centers"
  default     = ["dc1"]
}
variable "nomad_namespace" {
  type        = string
  description = "[Enterprise] Nomad namespace"
  default     = "default"
}
variable "nomad_job_name" {
  type        = string
  description = "Nomad job name"
  default     = "presto"
}

variable "local_docker_image" {
  type        = bool
  description = "Switch for nomad jobs to use artifact for image lookup"
  default     = false
}

variable "mode" {
  type        = string
  description = "Switch for nomad jobs to use cluster or standalone deployment"
  default     = "standalone"
  validation {
    condition     = var.mode == "standalone" || var.mode == "cluster"
    error_message = "Valid modes: \"cluster\" or \"standalone\"."
  }
}

# presto
variable "shared_secret_user" {
  type        = string
  description = "Shared secret provided by user"
  default     = "defaultprestosecret"
  validation {
    condition     = length(var.shared_secret_user) >= 12
    error_message = "The length of the shared secret must be 12 characters or more."
  }
}

variable "vault_secret" {
  type = object({
    use_vault_secret_provider = string,
    vault_kv_policy_name      = string,
    vault_kv_path             = string,
    vault_kv_secret_key_name  = string
  })
  description = "Set of properties to be able fetch shared cluster secret from vault"
  default = {
    use_vault_secret_provider = true
    vault_kv_policy_name      = "kv-secret"
    vault_kv_path             = "secret/data/presto"
    vault_kv_secret_key_name  = "cluster_shared_secret"
  }
}

variable "service_name" {
  type        = string
  description = "Presto service name"
  default     = "presto"
}

variable "coordinator" {
  type        = bool
  description = "Include a coordinator in addition to the workers. Set this to `false` when extending an existing cluster"
  default     = true
}

variable "workers" {
  type        = number
  description = "cluster: Number of nomad worker nodes"
  default     = 1
}

variable "debug" {
  type        = bool
  description = "Turn on debug logging in presto nodes"
  default     = false
}

variable "consul_http_addr" {
  type        = string
  description = "Address to consul, resolvable from the container. e.g. http://127.0.0.1:8500"
}

variable "memory" {
  type        = number
  description = "Memory allocation for presto nodes"
  default     = 1024
  validation {
    condition     = var.memory >= 768
    error_message = "Presto can not run with less than 512MB of memory. 256MB is subtracted for OS. Total must be at least 768MB."
  }
}

variable "cpu" {
  type        = number
  description = "CPU allocation for presto nodes"
  default     = 500
  validation {
    condition     = var.cpu >= 500
    error_message = "Presto can not run with less than 300Mhz CPU."
  }
}

variable "docker_image" {
  type        = string
  description = "Presto docker image"
  default     = "prestosql/presto:341"
}

variable "consul_connect_plugin" {
  type = bool
  description = "Deploy consul connect plugin for presto"
  default = true
}

variable "consul_connect_plugin_version" {
  type        = string
  description = "Version of the consul connect plugin for presto (on maven central) src here: https://github.com/gugalnikov/presto-consul-connect"
  default     = "2.2.0"
}

variable "consul_connect_plugin_artifact_source" {
  type = string
  description = "Artifact URI source"
  default = "https://oss.sonatype.org/service/local/repositories/releases/content/io/github/gugalnikov/presto-consul-connect"
}

variable "container_environment_variables" {
  type        = list(string)
  description = "Presto environment variables"
  default     = [""]
}

variable "use_canary" {
  type = bool
  description = "Uses canary deployment for Presto"
  default = false
}

variable "hivemetastore" {
  type = object({
    service_name = string,
    port         = number,
  })
  default = {
    service_name = "hive-metastore"
    port         = 9083
  }
  description = "Hivemetastore data-object contains service_name and port"
}

variable "minio" {
  type = object({
    service_name = string,
    port         = number,
    access_key   = string,
    secret_key   = string,
  })
  description = "Minio data-object contains service_name, port, access_key and secret_key"
}
