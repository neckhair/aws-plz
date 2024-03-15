# Create the organization
resource "aws_organizations_organization" "root" {
  feature_set = "ALL"
}
