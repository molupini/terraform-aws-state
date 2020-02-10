
######################################################################
# resources - groups, users, access keys, membership, attach policy 
######################################################################

resource "aws_iam_group" "admin-group" {
  count = length(var.grp_tag)
  name  = var.grp_tag[count.index].Name
}

# # EXCLUDED, UNCOMMENT IF REQUIRED 
# resource "aws_iam_group" "read-group" {
#   name = data.external.readGroup.result["logicalName"]
# }

resource "aws_iam_group_membership" "admin-user" {
  count = length(var.grp_tag)
  name  = "add-${aws_iam_group.admin-group[count.index].name}"
  users = [
    # aws_iam_user.admin-user.name,
    data.aws_iam_user.run-user[count.index].user_name
  ]
  group = aws_iam_group.admin-group[count.index].name
}

# # EXCLUDED, UNCOMMENT IF REQUIRED 
# resource "aws_iam_group_membership" "read-user" {
#   name = "add-${aws_iam_group.read-group.name}"
#   users = [
#     aws_iam_user.read-user.name,
#   ]
#   group = aws_iam_group.read-group.name
# }

resource "aws_iam_group_policy" "admin-group" {
  count  = length(var.grp_tag)
  name   = "pol-${aws_iam_group.admin-group[count.index].name}"
  group  = aws_iam_group.admin-group[count.index].name
  policy = data.template_file.admin-user-policy[count.index].rendered
}

# # EXCLUDED, UNCOMMENT IF REQUIRED 
# resource "aws_iam_group_policy" "read-group" {
#   name   = "pol-${aws_iam_group.read-group.name}"
#   group  = aws_iam_group.read-group.name
#   policy = data.template_file.read-user-policy.rendered
# }