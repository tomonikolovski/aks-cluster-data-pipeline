# Azure AKS cluster terraform code to be used to deploy the data pipeline

1. Install Azure azcli
2. az login 
az account show
az account list --query "[?user.name=='<microsoft_account_email>'].{Name:name, ID:id, Default:isDefault}" --output Table
3. az account set --subscription "<subscription_id_or_subscription_name>"
3. Create a contributor role Service Principal Name for your Azure subscription to make sure admin credentials are not provided to Terraform
    - export MSYS_NO_PATHCONV=1
    - az ad sp create-for-rbac --name aks_cluster_spn --role Contributor --scopes /subscriptions/<subscription_id>
4. Save the output details and export the following environment variables
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"

