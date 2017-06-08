#!/bin/bash -e

. shared.sh
project=${project-openshift}
serviceUUID=${serviceUUID-$(oc get template cakephp-mysql-example -n $project -o template --template '{{.metadata.uid}}')}
planUUID=${serviceUUID-$(oc get template cakephp-mysql-example -n $project -o template --template '{{.metadata.uid}}')}

req="{
  \"plan_id\": \"$planUUID\",
  \"service_id\": \"$serviceUUID\",
  \"parameters\": {
    \"template.openshift.io/requester-username\": \"$requesterUsername\"
  }
}"

curl \
  -X PUT \
  -H 'X-Broker-API-Version: 2.9' \
  -H "Authorization: Bearer $(oc whoami -t)" -k \
  -H 'Content-Type: application/json' \
  -d "$req" \
  -v \
  $curlargs \
  $endpoint/v2/service_instances/$instanceUUID/service_bindings/$bindingUUID
