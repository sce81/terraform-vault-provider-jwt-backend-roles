variable "role_name" {
  type        = string
  default     = "tfc-vault-admin-role"
  description = "Vault role name for the initial role"
}

variable "tfc_vault_audience" {
  type        = string
  default     = "vault.workload.identity"
  description = "The audience value to use in run identity tokens"
}

variable "tfc_hostname" {
  type        = string
  default     = "app.terraform.io"
  description = "The hostname of the TFC or TFE instance to use with Vault"
}

variable "tfc_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
}

variable "target_tfc_project" {
  type        = string
  default     = "vault-configuration"
  description = "The project under which the vault authentication will be valid"
}

variable "tfc_project_name" {
  type        = string
  default     = "Default Project"
  description = "The project under which a workspace will be created"
}

variable "vault_policy" {
  type        = string
  default     = null
  description = "Vault policy to associate with Terraform Platform"
}

variable "jwt_backend_path" {
  type        = string
  default     = "jwt"
  description = "Vault auth backend to associate role with"
}

variable "tfc_workspace_name" {
  type        = string
  description = "Name of the HCP Terraform workspace to create"
}

variable "variable_set_name" {
  type        = string
  description = "Name of the HCP Terraform variable set for Vault authentication"
}

variable "vault_url" {
  type        = string
  description = "Vault URL that HCP Terraform runs will access"
}

variable "vault_namespace" {
  type        = string
  default     = null
  description = "Vault namespace that HCP Terraform runs will access"
}
