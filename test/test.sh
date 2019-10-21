#! /bin/sh

RESOURCE_URL="${RESOURCE_BASE_URL}/index.html"

DURATION="1s"
RATE="25/1s"
CONCURRENT_USERS="25"
REQUEST_TIMEOUT="240s"

echo "Performance Test"
printf "Generate load simulating %s concurrent requests\n" $CONCURRENT_USERS

for i in 1 2 3; do
  printf "Run #%d on %s\n" $i "$(date)"

  echo "GET $RESOURCE_URL" | \
  vegeta attack -duration=$DURATION -rate=$RATE -workers=$CONCURRENT_USERS -redirects=-1 -timeout=$REQUEST_TIMEOUT | \
  vegeta report
done

