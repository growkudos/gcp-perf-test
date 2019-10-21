# Performance Test
This test is a speculative performance test of serving static assets from GCP.

## Create Web Server Image and Push to GCR
```
PROJECT_ID=kudos-spikes
# Generate index.html file larger than 500k
python3 -c 'for i in range(0,130000): print("test",end="")' > web-server/index.html
docker build -t gcr.io/$PROJECT_ID/gcp-perf-test-nginx web-server/
docker push gcr.io/$PROJECT_ID/gcp-perf-test-nginx
```

## Create Infrastructure and Deploy Web Server
Create VM in Google Cloud Platform running the docker container based on the image previously built.

Based on gcloud command line:

```
PROJECT_ID=kudos-spikes \
CONTAINER_IMAGE=gcr.io/$PROJECT_ID/gcp-perf-test-nginx \
bash infrastructure.sh
```

## Run Test and Print Report
```
docker build -t gcp-perf-test-nginx test/
URL="http://`gcloud compute instances describe gcp-perf-test-nginx --format='get(networkInterfaces[0].accessConfigs[0].natIP)'`"
docker run --env RESOURCE_BASE_URL="$URL" gcp-perf-test-nginx
```
