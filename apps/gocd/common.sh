#!/bin/bash
#set -e


function export_variable {
  ARG_NAME=$1
  ARG_VALUE=$2
  eval "export $ARG_NAME=$ARG_VALUE"
}

function enforce_arg {
  ARG_NAME="$1"
  ARG_DESC="$2"
  ARG_VALUE="${!1}"

  if [ -z "$ARG_VALUE" ]; then
    echo " - $ARG_NAME ($ARG_DESC) is a required value.  Please ensure it is set in vars.env "
    exit 1
  else
    export_variable "$ARG_NAME" "$ARG_VALUE"
    return;
  fi
}

function kubectl_cmd() {
  kubectl --namespace=$KUBE_NAMESPACE $*
}

function gcloud_config()
{

echo "Google cloud authentication"
gcloud auth activate-service-account --key-file ./credentials.json
echo "Google cloud config"
gcloud config set project $project
gcloud config set compute/zone $subnet_region-c
gcloud config set container/cluster $KUBE_CLUSTER
}
function gcloud_auth() {
echo "Google cloud cluster $KUBE_CLUSTER login"
gcloud container clusters get-credentials  $KUBE_CLUSTER --zone $subnet_region-c  --project $project
}

function tag() {
  docker tag $1:latest $GCP_REGISTRY/$1:latest
}

function push() {
  gcloud docker -- push $GCP_REGISTRY/$1:latest
}

function tag_and_push() {
  tag $1
  push $1
}

function apply() {
  envsubst < $1 | kubectl --namespace=$KUBE_NAMESPACE apply -f -
}

function yesno {
  read -r -p "Do you want to continue? [y/N] " response
  case "$response" in
    [yY][eE][sS]|[yY])
			echo ""
      return 0;
      ;;
    *)
			echo ""
      return 1
      ;;
  esac
}

function confirm {
  if ! yesno; then
    echo "Aborting."
    exit 1
  fi
}

function validate_config {
	source ./apps/gocd/vars.env
  source ./envs/$STACK/$ENV.tfvars
	enforce_arg "GO_USERNAME" "Username for GoCD master"
	enforce_arg "GO_PASSWORD" "Password for GoCD master"
	enforce_arg "AGENT_AUTO_REGISTER_KEY" "Unique key that agents use to self register"
	enforce_arg "KUBE_NAMESPACE" "The namespace to deploy GoCD to"
  enforce_arg "project" "gcloud project id"
  enforce_arg "subnet_region" "gcloud region"
	export_variable "GCP_REGISTRY" "$GCP_REGISTRY_HOST/$(gcloud config get-value project 2>/dev/null | /usr/bin/xargs)"
	export_variable "SECRET_NAME" "kube-gocd"
  export_variable "KUBE_CLUSTER" "$STACK-$ENV"

  echo "Checking configuration..."
  echo " + GoCD username: $GO_USERNAME"
  echo " + GoCD password: $GO_PASSWORD"
  echo " + Agent registration key: $AGENT_AUTO_REGISTER_KEY"
  echo " + GCP registry: $GCP_REGISTRY"
  echo " + Kubernetes namespace: $KUBE_NAMESPACE"
  echo "Google cloud info..."
  echo " + Project: $project"
  echo " + zone: $subnet_region"
  echo " + cluster: $KUBE_CLUSTER"
  echo ""

  echo "Check, double check, and triple check the above configuration."
  echo "If you're not happy, quit, and edit vars.env"
  confirm
}


echo ""
