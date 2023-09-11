The main difference when using a resource name like "this" and mapping it to a variable is that the resource name "this" 
is a static name that you assign to the resource block, whereas mapping it to a variable allows you to dynamically assign 
different names to the resource based on the value of the variable.

By using "this" as the resource name for all resources, you are essentially giving them the same name across all resource 
blocks. This can be useful if you want to maintain consistency or simplicity in your resource naming scheme.

On the other hand, when you map the resource names to a variable, such as "aws_vpc.this" or "aws_internet_gateway.this", 
you have the flexibility to change the names based on the value of the variable. This can be helpful when you want to create 
multiple instances of the same resource with different names or when you want to provide more descriptive names based on
 certain criteria or conventions.

by using "this" as the resource name and mapping it to the variable, you can easily customize the names 
based on the environment (var.env). For example, the VPC resource would have a Name tag like "dev-main" or "prod-main" 
depending on the environment value.

Overall, using "this" as the resource name provides simplicity and consistency, while mapping it to a variable allows for 
more flexibility and customization in naming resources. The choice depends on your specific requirements and preferences for 
resource naming in your infrastructure.