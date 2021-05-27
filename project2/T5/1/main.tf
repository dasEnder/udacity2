# TODO: Designate a cloud provider, region, and credentials

provider "aws" {
 
  region = "us-east-1"
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "UdacityT2" {
  count = 4
  ami = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
#  named = "Udacity_T2"
  subnet_id = "subnet-32018d54"
#  vpc_security_group_ids = "sg-b8408a8e"
  tags = {
    type = "udacity_projrct2"
    note = "deleteme"
  }
}  

# TODO: provision 2 m4.large EC2 instances named Udacity M4
# resource "aws_instance" "UdacityM4" {
#   count = 2
#   ami = "ami-0323c3dd2da7fb37d"
#   instance_type = "m4.large"
# #  named = "Udacity_M4"
#   subnet_id = "subnet-32018d54"
# #  vpc_security_group_ids = "sg-b8408a8e"
#   tags = {
#     type = "udacity_projrct2"
#     note = "deleteme"
#   }
# }  