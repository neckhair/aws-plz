# AWS Personal Landing Zone

This module lets you manage your personal AWS landing zone. It is intended for personal use and
helps you manage your sandbox accounts. The resources created by this module should not cost
anything.

The aim of this module is not to create a super secure production environment. The focus is on
providing an easy and quick way to provision new AWS accounts for your own personal sandbox
projects.

For example, we use static secrets for our own access to the API and we store the Terraform state
in a local file. This is to keep the setup small and simple to use. As always, be careful where you
store your secrets.

## Example

Before you can use this example, you need to have access to an - perferably new - AWS account. See
the chapter bellow for a full setup guide.

```terraform
module "landing_zone" {
  source = "https://github.com/neckhair/aws-plz.git"

  username = "sam"

  accounts = {
    mysandbox01 = {
      name              = "Sandbox 01"
      email             = "sam+sandbox01@example.com"
      close_on_deletion = true
    }
  }
}
```

## Bootstraping your landing zone

This guide assumes you are familiar with the AWS CLI and Terraform and have both tools installed.

We want to automate as much as possible. But bootstraping your landing zone needs a couple of manual
steps. We recommend starting with a completely new account.

**TIP** 💡: You might need a new email address to create the main and sub-accounts. Many mail providers support
[plus aliases](https://kb.uconn.edu/space/IKB/10731880518/What+is+Plus+Email+Addressing+and+How+Do+I+Use+It%3F).
With that you can have as many addresses as you need, while still having only one inbox.

### Getting API access for Terraform

The first steps are done using our `root` account, just because we don't have a personal account yet.

Go to the [Security Credentials page](https://us-east-1.console.aws.amazon.com/iam/home#/security_credentials?section=IAM_credentials)
and under "Access Keys" create a new key pair ("Command Line Interface (CLI)" use case).

Then run the following command and enter those credentials:

```sh
aws configure
```

### Set up our Terraform repository

Now we can bootstrap our account with Terraform. Start in a fresh directory and create the following
files.

```terraform
# provider.tf
provider "aws" {
}

# main.tf
module "landing_zone" {
   source = "https://github.com/neckhair/aws-plz.git"

   # change these values to your personal taste
   username = "jimmy"
}

# output.tf
output "access_key" {
  value = module.landing_zone.access_key
}
output "secret" {
  value     = module.landing_zone.secret
  sensitive = true
}
output "password" {
  value     = module.landing_zone.password
  sensitive = true
}
```

**TIP** 🔥: The Terraform state is kept in a file in this directory. This should work for such a
small repo. But be carefull. It may contain secrets, so you don't want to push it with the rest of
your code into a public Github repo! Just make sure, you don't loose it. More advanced users
would choose a different, secure backend for their Terraform state.

```sh
echo "*.tfstate\n*.tfstate.*" >> .gitignore
```

Then set up our base resources:

```sh
terraform init
terraform apply
```

This is going to create a couple of important resources:

- An AWS Organization.
- A personal user account with admin access.
- An IAM policy to grant you access to sub-accounts.

### Clean up and login

Now we need to do some cleanup and get ready to actually use our new repo:

1. Delete the access key in your root account. It's not needed anymore and it's safer to get rid of
   it immediately.
1. Log in with your new user. Get the password from the Terraform state:

   ```sh
   terraform output -json | jq .password.value
   ```

1. Configure the AWS CLI with your new personal token:

   ```sh
   terraform output -json   # this shows your new credentials
   aws configure            # overwrite with your new credentials
   ```
