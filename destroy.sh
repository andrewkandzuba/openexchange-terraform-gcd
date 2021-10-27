#!/bin/bash
mkdir -p .cred
gcloud kms decrypt --key=terraform-key --keyring=openexchange-webservice-go --location=global --ciphertext-file=terraform.json.enc --plaintext-file=.cred/terraform.json
terraform destroy -auto-approve
rm -R .cred/