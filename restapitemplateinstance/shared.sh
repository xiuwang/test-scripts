#!/bin/bash -e

instanceUUID=${instanceUUID-a71f7ab8-e448-4826-8f05-32a185222dd7}
bindingUUID=${bindingUUID-dde0226b-ff95-4f9d-af51-2e9ec06b1f02}

endpoint=${endpoint-https://localhost:8443/brokers/template.openshift.io}
curlargs=${curlargs--k}
namespace=${namespace-demo}
requesterUsername=${requesterUsername-$(oc whoami)}
