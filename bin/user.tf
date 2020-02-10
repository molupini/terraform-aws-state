######################################################################
# data  
######################################################################
data "aws_iam_user" "run-user" {
  count     = length(var.state_config)
  user_name = var.state_config[count.index].runAs
}


######################################################################
# resources - groups, users, access keys, membership, attach policy 
######################################################################

# resource "aws_iam_user" "read-user" {
#   name = data.external.readUser.result["logicalName"]
# }

# resource "aws_iam_access_key" "admin-user" {
#   user = aws_iam_user.admin-user.name
# }

# resource "aws_iam_access_key" "read-user" {
#   user = aws_iam_user.read-user.name
# }
