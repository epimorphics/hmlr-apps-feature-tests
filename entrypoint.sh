#! /bin/bash
if [ -z "$LR_URL" ]
then
  echo "LR_URL undefined"
  exit 1
fi

if [ -n "$HEADLESS" ]
then
  export MOZ_HEADLESS=1
else
  export TEST_BROWSER_VISIBLE=1
fi

IFS=':' read -a url <<< "$LR_URL"

export TEST_PROTO=${url[0]}
export TEST_HOST=$(cut -b3- <<< ${url[1]})
export TEST_PORT=${url[2]:-80}

echo Testing endpoint $TEST_PROTO://$TEST_HOST:$TEST_PORT

bundle exec cucumber --tags 'not @ci-exclude'
