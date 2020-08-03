package test

import (
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/stretchr/testify/assert"
	"strconv"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"
)

const (
	myAccountId = "943185707580"
	region      = "ap-south-1"
)

func TestTerraformAwsVpcStructure(t *testing.T) {
	//t.Parallel() //turn this on if parallel execution is required out of table Tests

	workingDir := "../02-aws"
	awsRegion := region
	allowedAccountId := []string{myAccountId}
	vpcCIDR := "172.31.0.0/16"
	subnetCIDR := "172.31.0.0/20"
	name := "hp"
	env := "qa"

	defer test_structure.RunTestStage(t, "terraform_destroy", func() {
		terraformDestroy(t, workingDir)
	})

	test_structure.RunTestStage(t, "terraform_apply", func() {
		terraformApply(t, awsRegion, workingDir, allowedAccountId, name, env, vpcCIDR, subnetCIDR)
	})

	test_structure.RunTestStage(t, "validate_vpc", func() {
		validateVpc(t, awsRegion, workingDir, allowedAccountId, name, env, vpcCIDR, subnetCIDR)
	})
}

func terraformApply(t *testing.T, awsRegion string, workingDir string, allowedAccountId []string,
	name string, env string, vpcCIDR string, subnetCIDR string) {

	terraformOptions := &terraform.Options{
		TerraformDir: workingDir,
		Vars: map[string]interface{}{
			"allowed_accnt_ids": allowedAccountId,
			"vpc_cidr":          vpcCIDR,
			"subnet_cidr":       subnetCIDR,
			"name":              name,
			"env":               env,
		},
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	test_structure.SaveTerraformOptions(t, workingDir, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}

func terraformDestroy(t *testing.T, workingDir string) {
	terraformOptions := test_structure.LoadTerraformOptions(t, workingDir)
	terraform.Destroy(t, terraformOptions)
}


func validateVpc(t *testing.T, awsRegion string, workingDir string, allowedAccountId []string,
	name string, env string, vpcCIDR string, subnetCIDR string) {
	terraformOptions := test_structure.LoadTerraformOptions(t, workingDir)

	actualAccountId := aws.GetAccountId(t)
	expectedAccountId := allowedAccountId[0]


	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	actualSubnetCount := strconv.Itoa(len(aws.GetSubnetsForVpc(t, vpcID, awsRegion)))
	expectedSubnetCount := strconv.Itoa(1)


	equalTests := []struct {
		name     string
		actual   string
		expected string
	}{
		{"Check Account ID:", actualAccountId, expectedAccountId},
		{"Check Subnet Count:", actualSubnetCount, expectedSubnetCount},
	}
	for _, tt := range equalTests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel() // marks each test case as capable of running in parallel with each other
			assert.Equal(t, tt.expected, tt.actual)
		})
	}

	subnetID := terraform.Output(t, terraformOptions, "subnet_id")
	t.Run("Check Public Subnet", func(t *testing.T){
		assert.False(t, aws.IsPublicSubnet(t, string(subnetID), awsRegion))
	})


	actualVpcTags := terraform.OutputMap(t, terraformOptions, "vpc_tags")
	containsTests := []struct {
		name     string
		actual   string
		contains string
	}{
		{"Check Tag VPC Name:", actualVpcTags["Name"], name},
		{"Check Tag VPC Environment:", actualVpcTags["Env"], env},
		{"Check Tag VPC Terraform:", actualVpcTags["Terraform"], "yes"},
	}
	for _, tt := range containsTests {
		tt := tt
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel() // marks each test case as capable of running in parallel with each other
			assert.Contains(t, tt.actual, tt.contains)
		})
	}
}
