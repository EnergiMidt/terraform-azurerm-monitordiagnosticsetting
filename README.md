# [terraform-azurerm-diagnosticsetting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

Manages a Diagnostic Setting for an existing Resource.

## Getting Started

- Format and validate Terraform code before commit.

```shell
terraform init -upgrade \
    && terraform init -reconfigure -upgrade \
    && terraform fmt -recursive . \
    && terraform fmt -check \
    && terraform validate .
```

- Always fetch latest changes from upstream and rebase from it. Terraform documentation will always be updated with GitHub Actions. See also [.github/workflows/terraform.yml](.github/workflows/terraform.yml) GitHub Actions workflow.

```shell
git fetch --all --tags --prune --prune-tags \
  && git pull --rebase --all --prune --tags
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.41.0, < 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.43.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | (Required) Specifies the application name of within the system according to naming convention guidelines.<br>  Will be part of the final name of the deployed resource. | `string` | n/a | yes |
| <a name="input_diagnostic_target_resource_id"></a> [diagnostic\_target\_resource\_id](#input\_diagnostic\_target\_resource\_id) | (Required) The ID of an existing Resource on which to configure Diagnostic Settings.<br>  Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) The name of the environment. | `string` | n/a | yes |
| <a name="input_log_category_types"></a> [log\_category\_types](#input\_log\_category\_types) | (Required) The list of Diagnostic Log Category Types.<br>  The Log Categories available vary depending on the Resource being used.<br>  You may wish to use the `azurerm_monitor_diagnostic_categories` Data Source or list of service specific schemas to identify which categories are available for a given Resource. | `list(string)` | n/a | yes |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | (Optional) The list of Diagnostic Metrics.<br>  The Metric Categories available vary depending on the Resource being used.<br>  You may wish to use the `azurerm_monitor_diagnostic_categories` Data Source to identify which categories are available for a given Resource. | `list(string)` | `[]` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | `"00000000-0000-0000-0000-000000000000"` | no |
| <a name="input_system_short_name"></a> [system\_short\_name](#input\_system\_short\_name) | (Required) Specifies the short abbreviation of the system name according to naming convention guidelines.<br>  Will be part of the final name of the deployed resource. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_monitor_diagnostic_setting"></a> [azurerm\_monitor\_diagnostic\_setting](#output\_azurerm\_monitor\_diagnostic\_setting) | Manages a Diagnostic Setting for an existing Resource. |
<!-- END_TF_DOCS -->
