We can use the module to reuse the code written in submodules
Consider i created a template of ec2 in submodule, I can re-use the ec2 template in the root module like if i need to use multiple ami_id for different instance i can push it 
from the root module




When writing the custom module the challeges that we will face is that to pass the variable that generated in one module to another module.

we can take out the information from one submodule using output.tf
If we are using module inside module then there is no need to output block we can directly mention in root ./main file like module.vpc.id

