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

## Building Modules
Best Practices:
- Use object attributes: group related information under object-type variables
- Separate long-lived from short-lived infrastructure: resources that change rarely should not be grouped together with resources that change often
- Do not try to cover every edge case: this can quickly lead to highly complex modules, which are difficult to maintain and configure. Modules should be reusable blocks of infrastructure, and catering to edge cases goes against that purpose.
- Support only the necessary configuration variables: do not expose all the internals of the module for the configuration via variables. This hurts encapsulation and makes the module harder to work with.
- Ouput as much information as possible: even if there is no clear use for some information, providing it as an output will make the module easier to use in future scenarios.
- Define a stable input and output interface: All used variables and outputs create coupling to the module. The more coupling, the harder it is to change the interface without breaking changes. 
- Extensively document variables and outputs: this help the modules's users to quickly understand the module's interface and to work more effectively with it
- Favor a flat and composable module structure instead of deeply nested modules: deeply nested modules become harder to maintain over time and increase the configuration complexity for the module's users.
- Make assumptions and guarantees explicit via custom conditions: do not rely on the users always passing valid input values. Thoroughly validate the infrastructure created by the module to ensure it complies with the requirements the module must fulfill.
- Make a module's dependencies explicit via input variables: data sources can be used to retrieve information a module needs, but they create implicit dependencies, which are much harder to identify and understand. Opt for making these dependencies explicit by requiring the information via input variables.
- Keep a module's scope narrow: do not try to do everything inside a single module.


## Useful Commands
```sh
terraform init -backend-config="dev.s3.tfbackend" -migrate-state
```
migrate state is needed if your original state file is not in the location stated in tfbackend. This will copy the state file over to the location specified in tfbackend file, but will not delete state file in the original location, will need to go to the console to delete.

```sh
terraform plan -var-file="dev.terraform.tfvars"
```
let's say if you have different tfvars file for different environment (dev and prod) and you named it differently from `terraform.tfvars`, terraform plan will not pick this file up unless specified.

If you have another file named `xxx.auto.tfvars`, `then auto.tfvars` file will have higher precedence over `terraform.tfvars` file.


```sh
terraform plan | grep instance_type
```
useful to just fetch certain information from terraform plan 

```sh
terraform output -help
# e.g.
terraform output -json 
terraform output s3_bucket_name
terraform output -raw s3_bucket_name # output return without double quotations
```
reads an output variable from a Terraform state file and prints the value.