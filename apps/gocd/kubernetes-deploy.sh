#!/bin/bash -
PATH_CURRENT="./apps/gocd"
export STACK=$1
export ENV=$2

source $PATH_CURRENT/common.sh

validate_config

gcloud_config
gcloud_auth

if [ ! "$1" = "--deploy-only" ]; then
  docker-compose -f $PATH_CURRENT/docker-compose.yml build
  tag_and_push "kube-gocd-master"
  tag_and_push "kube-gocd-master-cron"
  tag_and_push "kube-gocd-agent"
fi



if ! kubectl_cmd get namespaces | grep $KUBE_NAMESPACE &>/dev/null; then
	kubectl_cmd create namespace $KUBE_NAMESPACE
fi

if kubectl_cmd get secrets | grep $SECRET_NAME &>/dev/null; then
	kubectl_cmd delete secret $SECRET_NAME
fi

kubectl_cmd create secret generic $SECRET_NAME \
	--from-literal=user=$GO_USERNAME \
	--from-literal=pass=$GO_PASSWORD \
	--from-literal=agent_key=$AGENT_AUTO_REGISTER_KEY

EXISTING=0
if kubectl_cmd get pods | grep gocd &>/dev/null; then
	EXISTING=1
fi

apply $PATH_CURRENT/kubernetes/master.pod.yml
apply $PATH_CURRENT/kubernetes/agent.pod.yml

if [ "$EXISTING" = "1" ]; then
	kubectl_cmd delete pod -l tier=gocd
fi
