# Simple Log Analytics example

Configuration in this directory creates a test resource group and then deploys a log analytics account and automation account. The diagnostic settings for the automation account are then configured.
This also demonstrates the usage of the `ds_depends_on` variable.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.