output "account_id" {
  value       = aws_organizations_account.this.id
  description = "The account ID"
}

output "name" {
  value       = aws_organizations_account.this.name
  description = "Name of the account"
}

output "role_arn" {
  value = "arn:aws:iam::${aws_organizations_account.this.id}:role/${coalesce(aws_organizations_account.this.role_name, "OrganizationAccountAccessRole")}"

}
