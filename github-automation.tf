resource "spacelift_stack" "github_automation" {
  administrative = false
  autodeploy     = false

  name           = "github-automation"
  description    = ""
  manage_state   = false
#   worker_pool_id = "01FQ0MDWV3B44RGJ7QBV0K59HB"

  repository = "github-automation-2"
  branch     = "main"

  terraform_version = var.terraform_version
  runner_image      = var.spacelift_runner_image

  before_init = [
    "git config --global url.\"https://foo:$${GITHUB_TOKEN}@github.com/hieu-ldt\".insteadOf \"https://github.com/hieu-ldt\""
  ]
  after_init = [
    "terraform fmt -recursive -check",
    "tflint --init",
    "tflint --disable-rule=terraform_module_pinned_source",
    "tfsec .",
    "checkov -d . --framework=terraform --quiet --skip-check CKV_GIT_1"
  ]
}

resource "spacelift_environment_variable" "github_owner" {
  context_id = "githubhttpscredentials"
  name       = "GITHUB_OWNER"
  value      = "hieu-ldt"
  write_only = false
}
