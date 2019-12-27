# terraform-azurerm-diagnostic-setting
Terraform module to create diagnostic settings for other resources

![Terraform Version](https://img.shields.io/badge/Terraform-0.12.6-green.svg)

## Dependencies

This module has a workaround implemented for Terraform not supporting `depends_on` in modules. To use this, use the `ds_depends_on` in the same way you would use `depends_on` when calling the module.
For example usage, please see the examples folder.

## Special Notes:

- If diagnostics are enabled, then you *need* to configure the log analytics workspace ID, otherwise you can leave it as null.

## References

Source for module dependency workaround: https://discuss.hashicorp.com/t/tips-howto-implement-module-depends-on-emulation/2305/2
