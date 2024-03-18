data "aws_iam_policy_document" "sub_account_access" {
  statement {
    actions   = ["sts:AssumeRole"]
    effect    = "Allow"
    resources = [for account in module.accounts : account.role_arn]
  }
}
resource "aws_iam_policy" "sub_account_access" {
  name   = "GrantAccessToOrganizationAccountAccessRole"
  policy = data.aws_iam_policy_document.sub_account_access.json
}
resource "aws_iam_group_policy_attachment" "sub_account_access" {
  policy_arn = aws_iam_policy.sub_account_access.arn
  group      = aws_iam_group.admins.id
}
