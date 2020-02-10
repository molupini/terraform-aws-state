######################################################################
# resources - dynamodb, s3
######################################################################
resource "aws_dynamodb_table" "dyn_state" {
  count          = length(var.dyn_tag)
  name           = var.dyn_tag[count.index].Name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.dyn_tag[count.index]
}

resource "aws_s3_bucket" "s3_state" {
  count         = length(var.s3_tag)
  bucket        = var.s3_tag[count.index].Name
  region        = var.aws_region
  acl           = "private"
  force_destroy = true
  versioning {
    enabled = true
  }
  policy = data.template_file.s3-policy[count.index].rendered

  tags = var.s3_tag[count.index]
}
