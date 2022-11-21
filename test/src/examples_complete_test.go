package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"os"
	"testing"
)

// TestExamplesComplete tests a typical deployment of this module
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/complete",
		BackendConfig: map[string]interface{}{
			"bucket": os.Getenv("TF_STATE_BUCKET"),
			"key":    os.Getenv("TF_VAR_git"),
		},
		EnvVars: map[string]string{},
		Vars:    map[string]interface{}{},
	}
	terraform.Init(t, terraformOptions)
	removeCacheFromState(t, terraformOptions)
	terraform.ApplyAndIdempotent(t, terraformOptions)
}

func removeCacheFromState(t *testing.T, options *terraform.Options) {
	t.Log("removing ecr cache resources from state")
	_, _ = terraform.RunTerraformCommandE(t, options, "state", "rm", "module.this.module.iam_auth_lambda[0].module.ecr_cache[0].null_resource.sync_image_to_ecr")
	_, _ = terraform.RunTerraformCommandE(t, options, "state", "rm", "module.this.module.iam_auth_lambda[0].null_resource.wait_for_ecr")
}
