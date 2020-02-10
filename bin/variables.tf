##########################################################
# Create remote state configuration 
##########################################################


##########################################################
# variables
##########################################################

variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "aws_region" {
}
# variable "link" {
#   default = "null"
# }
variable "dyn_tag" {
  type = list(any)
}
variable "s3_tag" {
  type = list(any)
}
variable "state_config" {
  type = list(any)
}
variable "grp_tag" {
  type = list(any)
}
