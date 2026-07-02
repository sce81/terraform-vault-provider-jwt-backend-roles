## HCP Terraform Configuration

resource "tfe_workspace" "my_workspace" {
  name         = var.tfc_workspace_name
  organization = var.tfc_organization_name
  project_id   = data.tfe_project.tfc_project.id
}

resource "tfe_variable_set" "vault-auth" {
  name         = var.variable_set_name
  description  = "HCP Vault JWT Auth Parameters"
  organization = var.tfc_organization_name
}

resource "tfe_variable" "enable_vault_provider_auth" {
  key             = "TFC_VAULT_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  variable_set_id = tfe_variable_set.vault-auth.id
  description     = "Enable the Workload Identity integration for Vault."
}

resource "tfe_variable" "tfc_vault_addr" {
  key             = "TFC_VAULT_ADDR"
  value           = var.vault_url
  category        = "env"
  variable_set_id = tfe_variable_set.vault-auth.id
  description     = "The address of the Vault instance runs will access."
}

resource "tfe_variable" "tfc_vault_role" {
  key             = "TFC_VAULT_RUN_ROLE"
  value           = vault_jwt_auth_backend_role.tfc_role.role_name
  category        = "env"
  variable_set_id = tfe_variable_set.vault-auth.id
  description     = "The Vault role runs will use to authenticate."
}

resource "tfe_variable" "tfc_vault_namespace" {
  key             = "TFC_VAULT_NAMESPACE"
  value           = var.vault_namespace
  category        = "env"
  variable_set_id = tfe_variable_set.vault-auth.id
  description     = "Sets the variable set env variable for which namespace to operate at"
}

## Vault Configuration

resource "vault_jwt_auth_backend" "tfc_jwt" {
  path               = var.jwt_backend_path
  type               = "jwt"
  oidc_discovery_url = "https://${var.tfc_hostname}"
  bound_issuer       = "https://${var.tfc_hostname}"
}

resource "vault_jwt_auth_backend_role" "tfc_role" {
  backend        = vault_jwt_auth_backend.tfc_jwt.path
  role_name      = var.role_name
  token_policies = [vault_policy.tfc_policy.name]

  bound_audiences   = [var.tfc_vault_audience]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${var.tfc_organization_name}:project:${var.target_tfc_project}:workspace:*:run_phase:*"
  }
  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200
}

resource "vault_policy" "tfc_policy" {
  name = "${var.role_name}-policy"

  policy = var.vault_policy
}
