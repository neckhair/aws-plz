variable "username" {
  description = "Name of your main IAM user account."
  type        = string
}

variable "accounts" {
  description = "Define your accounts"
  type = map(object({
    name              = string
    email             = string
    close_on_deletion = bool
  }))
  default = {}
}
