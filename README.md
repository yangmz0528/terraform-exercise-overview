# Notes

## Terraform Stages
1. Plan - everything/resources that terraform would like to plan
2. Apply - apply these changes
3. Destroy - destroy the resources created

## Commands
1. `terraform init` - initialise your working directory. This command prepares your directory for other Terraform commands and ensures that Terraform has everything it needs to run
2. `terraform plan` - create an execution plan. This command determines what actions are necessary to achieve the desired state specified in your configuration files
3. `terraform apply` - this command will make necessary changes to reach the desired state of your configuration
4. `terraform destroy` - remove all resources created by your Terraform configuration. This will also clean up the state.

## Terraform Block
1. `terraform` - only contstants are allowed within the terraform block. Input variables or resource reference are not allowed.
2. `cloud` - used to configure Terraform Cloud.
3. `backend` = used to configure a state backend for the project
4. `required_version` - used to specify the accepted versions of Terraform for the current project.
5. `required_providers` - specifies the required providers for the current proejcts or module, including their accepted versions.

## Backends
Backends define where Terraform stores its state file
There are multiple types of backends, which can be place into three categories:
- Local: the state file is stored in the user's local machine
- Terraform Cloud: the state file is stored in Terraform Cloud
- 3rd-party remote backends: the state file is stored in a remote backend different from Terraform Cloud (e.g. S3, Google Cloud Storage, Azure Resource Manager/Blob Storage, among others)

## Meta-Arguments
- `depends_on`: used to explicitly define dependencies between resources
- `count` and `for_each`: allow the creation of multiple resources of the same time without having to declare separate resource blocks
- `provider`: allows defining explicitly which provider to use with a specific resource
- `lifecycle`
    - `create_before_destroy`: prevents tf's default behaviour of destroying before creating resources that cannot be updated in-place. The behaviour is propakgated to all resource's dependencies
    - `prevent_destroy`: tf exits with an error if the planned changes would lead to the destruction of the resource marked with this
    - `replace_triggered_by`: replace the reousrce when any of the referenced item change
    - `ignore_changes`: we can provide a list of attributes that should not trigger an update when modified outside tf
## Useful Commands
```sh
terraform init -backend-config="dev.s3.tfbackend" -migrate-state
```
migrate state is needed if your original state file is not in the location stated in tfbackend. This will copy the state file over to the location specified in tfbackend file, but will not delete state file in the original location, will need to go to the console to delete.