module "accounts" {
  source   = "./account"
  for_each = var.accounts

  name              = each.value.name
  email             = each.value.email
  close_on_deletion = each.value.close_on_deletion
}
