

provider "github" {
  organization = "nayak-org"
  version      = "2.9.2"
}

resource "github_repository" "this" {
  name = "terraform-training-demo"
}



