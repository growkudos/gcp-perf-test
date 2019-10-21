# Performance Test
This test is a speculative performance test about serving static assets from GCP.

## Prerequisites
1. Docker
2. Python 3
3. gcloud CLI

## 1. Create Web Server Image and Push to GCR

Create a docker image based on nginx in order to serve a static asset of 500KB+.

```
PROJECT_ID=kudos-spikes
# Generate index.html file larger than 500k
python3 -c 'for i in range(0,130000): print("test",end="")' > web-server/index.html
docker build -t gcr.io/$PROJECT_ID/gcp-perf-test-nginx web-server/
docker push gcr.io/$PROJECT_ID/gcp-perf-test-nginx
```

## 2. Create Infrastructure and Deploy Web Server
Create a VM in Google Cloud Platform running a docker container based on the image previously built.

```
PROJECT_ID=kudos-spikes \
CONTAINER_IMAGE=gcr.io/$PROJECT_ID/gcp-perf-test-nginx \
bash infrastructure.sh
```

## 3. Run Test and Print Report
Run a load test using [vegeta](https://github.com/tsenart/vegeta). 

The load is configurable through the test/test.sh file.

```
docker build -t gcp-perf-test-nginx test/
URL="http://`gcloud compute instances describe gcp-perf-test-nginx --format='get(networkInterfaces[0].accessConfigs[0].natIP)'`"
docker run --env RESOURCE_BASE_URL="$URL" gcp-perf-test-nginx
```
