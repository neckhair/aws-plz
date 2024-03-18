variable "name" {
  description = "Account Name"
  type        = string
}

variable "email" {
  description = "Account Email Address"
  type        = string
}

variable "close_on_deletion" {
  description = "Close the account when removed from repo"
  type        = bool
  default     = true
}
