#!/bin/bash -e

. shared.sh
project=${project-openshift}

serviceUUID=${serviceUUID-$(oc get template cakephp-mysql-example -n $project -o template --template '{{.metadata.uid}}')}
planUUID=${planUUID-$(oc get template cakephp-mysql-example -n $project -o template --template '{{.metadata.uid}}')}

req="{
  \"plan_id\": \"$planUUID\",
  \"service_id\": \"$serviceUUID\",
  \"context\": {
    \"platform\": \"kubernetes\",
    \"namespace\": \"$namespace\"
  },
  \"parameters\": {
    \"MYSQL_USER\": \"username\",
    \"template.openshift.io/requester-username\": \"$requesterUsername\"
  }
}"

curl \
  -X PUT \
  -H 'X-Broker-API-Version: 2.9' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $(oc whoami -t)" -k \
  -d "$req" \
  -v \
  $curlargs \
  $endpoint/v2/service_instances/$instanceUUID'?accepts_incomplete=true'
