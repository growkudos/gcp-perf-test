#! /bin/bash

# create infrustructure
PROJECT_ID="$PROJECT_ID"
VM_NAME="gcp-perf-test-nginx"
SERVICE_ACCOUNT="528190617158-compute@developer.gserviceaccount.com"
CONTAINER_IMAGE="$CONTAINER_IMAGE"

gcloud beta compute --project="$PROJECT_ID" instances create-with-container "$VM_NAME" --zone=europe-west2-a --machine-type=f1-micro --subnet=default --network-tier=PREMIUM --metadata=google-logging-enabled=true --maintenance-policy=MIGRATE --service-account="$SERVICE_ACCOUNT" --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server --image=cos-stable-77-12371-89-0 --image-project=cos-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=$"$VM_NAME" --container-image="$CONTAINER_IMAGE" --container-restart-policy=always --labels=container-vm=cos-stable-77-12371-89-0
