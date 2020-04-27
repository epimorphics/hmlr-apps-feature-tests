.PHONY: test-image release-test-image install-test-image test-dev test-preprod test-production test-server

include bin/dkr-config

export AWS_PROFILE = lr
SHELL=/bin/bash

test-image:
	@docker build -t ${TEST_CONTAINER_NAME}:${TEST_CONTAINER_VERSION} .

release-test-image:
	@docker tag ${TEST_CONTAINER_NAME}:${TEST_CONTAINER_VERSION} ${REGISTRY}/${TEST_CONTAINER_NAME}:${TEST_CONTAINER_VERSION}
	@docker push ${REGISTRY}/${TEST_CONTAINER_NAME}:${TEST_CONTAINER_VERSION}

install-test-image:
	@docker pull ${REGISTRY}/${TEST_CONTAINER_NAME}:${TEST_CONTAINER_VERSION}
	@docker tag ${REGISTRY}/${TEST_CONTAINER_NAME}:${TEST_CONTAINER_VERSION} ${TEST_CONTAINER_NAME}:${TEST_CONTAINER_VERSION}

test-dev:
	TEST_URL=https://lr-ppd-dev-pres.epimorphics.net TEST_LB=true bin/dkr-test

test-preprod:
	bin/dkr-test-preprod

test-production:
	TEST_URL=https://landregistry.data.gov.uk TEST_LB=true bin/dkr-test
	
test-server:
	TEST_URL=$(TEST_URL) bin/dkr-test 
