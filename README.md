Reference:
https://learn.microsoft.com/en-us/azure/aks/learn/quick-kubernetes-deploy-terraform?tabs=bash

1.az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<subscription_id>
2.Export ENV
	export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
	export ARM_TENANT_ID="<azure_subscription_tenant_id>"
	export ARM_CLIENT_ID="<service_principal_appid>"
	export ARM_CLIENT_SECRET="<service_principal_password>"
3. Update terraform.tfvars with names u like
4. terraform init --upgrade
5. terraform plan -out main.tfplan --var-file=./terraform.tfvars
6. terraform apply main.tfplan

Deploying Workload:
1. Get kubeconfig echo "$(terraform output kube_config)" > ./azurek8s
2. Export Kubeconfig export KUBECONFIG=./azurek8s
3. kubectl apply -f aks-store-quickstart.yaml
4. To watch app in browser kubectl get service store-front --watch ( use public IP)

To Destroy:
1. terraform plan -destroy -out main.destroy.tfplan --var-file=./terraform.tfvars
2. terraform apply main.destroy.tfplan

