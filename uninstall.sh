#!/bin/bash

mkdir -p .cred

gcloud kms decrypt --key=redhat-openshift-registry --keyring=openexchange-webservice-go --location=global --ciphertext-file=rh-osh-registry.token.enc --plaintext-file=.cred/rh-osh-registry.token

gcloud container clusters get-credentials edu

RHOSHTOKEN=`cat ".cred/rh-osh-registry.token" | base64 -d`

template=`cat "klusterlet.yaml" | sed "s/{{RHOSHTOKEN}}/$RHOSHTOKEN/g"`

echo "$template" | kubectl delete -f -

kubectl delete -f status.yaml

rm -R .cred/
