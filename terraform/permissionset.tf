# Data block to fetch the SSO admin instance. Once you enabled SSO admin from console, you need data block to fetch this in your code.

data "aws_ssoadmin_instances" "ssoadmininst" {}

data "aws_caller_identity" "current" {}

########################### Groups #################################################
# Create Group
resource "aws_identitystore_group" "s3opsgroup" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmininst.identity_store_ids)[0]
  display_name      = "S3-ops-group"
  description       = "This is my AWS ops Group"
}


####################### Group Membership ############################################
# Create Group Membership for the user
# resource "aws_identitystore_group_membership" "example" {
#   identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmininst.identity_store_ids)[0]
#   group_id          = aws_identitystore_group.s3opsgroup.group_id
#   member_id         = aws_identitystore_user.example.user_id
# }

##################### Permission Sets #######################################

# Create Custom Permission Set for S3 Read only
resource "aws_ssoadmin_permission_set" "s3radonly" {
  name         = "read-only-s3-permissionset"
  instance_arn = tolist(data.aws_ssoadmin_instances.ssoadmininst.arns)[0]
}

data "aws_iam_policy_document" "s3radonlypolicydoc" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

# Custom permission set Inline policy 
resource "aws_ssoadmin_permission_set_inline_policy" "ssoadminpermissionsetinlinepolicy" {
  inline_policy      = data.aws_iam_policy_document.s3radonlypolicydoc.json
  instance_arn       = tolist(data.aws_ssoadmin_instances.ssoadmininst.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.s3radonly.arn
}

########################## AWS Account/OU Assignment ###################################


# Create Account Assignment to the group with Custom permission sets  --> Production Account 
resource "aws_ssoadmin_account_assignment" "example" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.ssoadmininst.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.s3radonly.arn # Custom Permission set

  principal_id   = aws_identitystore_group.s3opsgroup.group_id # Group
  principal_type = "GROUP"

  target_id   = data.aws_caller_identity.current.account_id   # Production Account
  target_type = "AWS_ACCOUNT"
  # target_type = "AWS_OU"      #incase you want to target OU.
}