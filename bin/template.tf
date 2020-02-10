######################################################################
# template - polices
######################################################################
# # SEE REGULAR TEMPLATE, AS THIS IS RUNAS ONLY 
data "template_file" "s3-policy" {
  count    = length(var.s3_tag)
  template = file("./templates/aws-s3-policy-runas.tpl")

  vars = {
    # # EXCLUDED, UNCOMMENT IF REQUIRED 
    # admin-user-arn = aws_iam_user.admin-user.arn
    # read-user-arn  = aws_iam_user.read-user.arn
    run-user-arn   = data.aws_iam_user.run-user[count.index].arn
    s3-bucket-name = var.s3_tag[count.index].Name
  }
}

data "template_file" "admin-user-policy" {
  count    = length(var.grp_tag)
  template = file("./templates/aws-admin-user.tpl")

  vars = {
    s3-bucket-arn = aws_s3_bucket.s3_state[count.index].arn
    dyn-table-arn = aws_dynamodb_table.dyn_state[count.index].arn
  }
}

# # EXCLUDED, UNCOMMENT IF REQUIRED 
# data "template_file" "read-user-policy" {
#   template = file("./templates/aws-read-user.tpl")

#   vars = {
#     s3-bucket-arn = aws_s3_bucket.s3_state.arn
#     dyn-table-arn = aws_dynamodb_table.dyn_state.arn
#   }
# }
