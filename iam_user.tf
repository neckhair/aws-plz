# Admin Group
data "aws_iam_policy" "aws_admin" {
  name = "AdministratorAccess"
}
resource "aws_iam_group" "admins" {
  name = "Admins"
}
resource "aws_iam_group_policy_attachment" "admins-aws-admin" {
  group      = aws_iam_group.admins.name
  policy_arn = data.aws_iam_policy.aws_admin.arn
}

# Main user account
resource "aws_iam_user" "main" {
  name = var.username
}
resource "aws_iam_group_membership" "admins" {
  name = "admin-group-mempership"

  group = aws_iam_group.admins.name
  users = [aws_iam_user.main.name]
}
resource "aws_iam_user_login_profile" "main" {
  user = aws_iam_user.main.name
}
resource "aws_iam_access_key" "main" {
  user = aws_iam_user.main.name
}
