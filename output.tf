output "access_key" {
  value       = aws_iam_access_key.main.id
  description = "The main user's access key for the AWS API."
}

output "secret" {
  value       = aws_iam_access_key.main.secret
  sensitive   = true
  description = "The main user's secret for the AWS API."
}

output "password" {
  value       = aws_iam_user_login_profile.main.password
  sensitive   = true
  description = "The main user's password for the AWS Management Console."
}

output "account_id" {
  value       = aws_organizations_organization.root.master_account_id
  description = "The ID of the master account."
}
