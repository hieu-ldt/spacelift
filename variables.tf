variable "terraform_version" {
  type        = string
  default     = "1.0.11"
  description = "Terraform version used across Spacelift stacks"
}

# https://github.com/alrajhi-my/man-spacelift-prerequisites/pull/4
variable "spacelift_runner_image" {
  type        = string
  default     = "public.ecr.aws/j8e3g0q9/spacelift-terraform-runner:latest"
  description = "Docker image that Spacelift worker pool uses to run CI and CD steps on"
}
