config {
  disabled_by_default = true
  # other options here...
}

plugin "google" {
  enabled = true
  version = "0.16.1"
  source  = "github.com/terraform-linters/tflint-ruleset-google"
}

# https://github.com/terraform-linters/tflint/blob/v0.35.0/docs/rules/terraform_comment_syntax.md
rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_deprecated_index" {
  enabled = true
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

# https://github.com/terraform-linters/tflint/blob/v0.35.0/docs/rules/terraform_documented_variables.md
rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_module_pinned_source" {
  enabled = true
}

rule "terraform_module_version" {
  enabled = true
}

# https://github.com/terraform-linters/tflint/blob/v0.35.0/docs/rules/terraform_naming_convention.md
rule "terraform_naming_convention" {
  enabled = true
  format = "mixed_snake_case"
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_required_version" {
  enabled = true
}

# https://github.com/terraform-linters/tflint/blob/v0.35.0/docs/rules/terraform_standard_module_structure.md
rule "terraform_standard_module_structure" {
  enabled = true
}

rule "terraform_typed_variables" {
  enabled = true
}

# https://github.com/terraform-linters/tflint/blob/v0.35.0/docs/rules/terraform_unused_required_providers.md
#rule "terraform_unused_required_providers" {
#  enabled = true
#}

rule "terraform_workspace_remote" {
  enabled = true
}

rule "google_compute_instance_invalid_machine_type" {
  enabled = true
}

rule "google_compute_instance_template_invalid_machine_type" {
  enabled = true
}

rule "google_compute_reservation_invalid_machine_type" {
  enabled = true
}

rule "google_container_cluster_invalid_machine_type" {
  enabled = true
}

rule "google_container_node_pool_invalid_machine_type" {
  enabled = true
}

rule "google_dataflow_job_invalid_machine_type" {
  enabled = true
}

rule "google_project_iam_audit_config_invalid_member" {
  enabled = true
}

rule "google_project_iam_binding_invalid_member" {
  enabled = true
}

rule "google_project_iam_member_invalid_member" {
  enabled = true
}

rule "google_project_iam_policy_invalid_member" {
  enabled = true
}
