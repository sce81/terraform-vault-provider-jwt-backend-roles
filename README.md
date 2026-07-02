# Terraform Vault Provider Auth
### All code is provided for reference purposes only and is used entirely at own risk. Code is for use in development environments only. Not intended for Production use. 

Configures Vault to trust Terraform to manage Vault at a specified location


##### Usage

    module "vault-auth" {
      source               = "git@github.com:sce81/Terraform-Vault-Provider-Auth.git"

        vault_url             = var.vault_url
        jwt_backend_path      = var.jwt_backend_path
        tfc_vault_audience    = var.tfc_vault_audience
        tfc_organization_name = var.tfc_organization_name
        tfc_project_name      = var.tfc_project_name
        tfc_workspace_name    = var.tfc_workspace_name
        vault_policy          = local.vault_policy
        vault_namespace       = var.vault_namespace
    }

#### Info


- HCP/Enterprise Terraform will configure Vault to trust workloads based on the identity of the Terraform instance executing the Terraform code.
- NB: Not compatible with Terraform Community Edition.
- The module should be called via a parent module detailing the configuration you require. Example located here: https://github.com/sce81/Terraform-Vault-Provider-Auth-Root-Module 
- The module will create a Vault JWT Auth backend called ${var.jwt_backend_path} .
- The module will create a Variable Set valid for Terraform Workspaces located with the target Project ${var.tfc_project_name}.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [tfe_variable.enable_vault_provider_auth](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_vault_addr](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_vault_namespace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfc_vault_role](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable_set.vault-auth](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set) | resource |
| [tfe_workspace.my_workspace](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [vault_jwt_auth_backend.tfc_jwt](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.tfc_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_policy.tfc_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [tfe_project.tfc_project](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_jwt_backend_path"></a> [jwt\_backend\_path](#input\_jwt\_backend\_path) | Vault auth backend to associate role with | `string` | `"jwt"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Vault role name for the initial role | `string` | `"tfc-vault-admin-role"` | no |
| <a name="input_target_tfc_project"></a> [target\_tfc\_project](#input\_target\_tfc\_project) | The project under which the vault authentication will be valid | `string` | `"vault-configuration"` | no |
| <a name="input_tfc_hostname"></a> [tfc\_hostname](#input\_tfc\_hostname) | The hostname of the TFC or TFE instance to use with Vault | `string` | `"app.terraform.io"` | no |
| <a name="input_tfc_organization_name"></a> [tfc\_organization\_name](#input\_tfc\_organization\_name) | The name of your Terraform Cloud organization | `string` | n/a | yes |
| <a name="input_tfc_project_name"></a> [tfc\_project\_name](#input\_tfc\_project\_name) | The project under which a workspace will be created | `string` | `"Default Project"` | no |
| <a name="input_tfc_vault_audience"></a> [tfc\_vault\_audience](#input\_tfc\_vault\_audience) | The audience value to use in run identity tokens | `string` | `"vault.workload.identity"` | no |
| <a name="input_tfc_workspace_name"></a> [tfc\_workspace\_name](#input\_tfc\_workspace\_name) | Name of the HCP Terraform workspace to create | `string` | n/a | yes |
| <a name="input_variable_set_name"></a> [variable\_set\_name](#input\_variable\_set\_name) | Name of the HCP Terraform variable set for Vault authentication | `string` | n/a | yes |
| <a name="input_vault_namespace"></a> [vault\_namespace](#input\_vault\_namespace) | Vault namespace that HCP Terraform runs will access | `string` | `null` | no |
| <a name="input_vault_policy"></a> [vault\_policy](#input\_vault\_policy) | Vault policy to associate with Terraform Platform | `string` | `null` | no |
| <a name="input_vault_url"></a> [vault\_url](#input\_vault\_url) | Vault URL that HCP Terraform runs will access | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->