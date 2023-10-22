# --- root/backends.tf ---

terraform {
  cloud {
    organization = "Onyenze"

    workspaces {
      name = "onyen-dev"
    }
  }
}