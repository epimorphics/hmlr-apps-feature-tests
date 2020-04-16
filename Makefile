.PHONY: image install release headless gui

REGISTRY=018852084843.dkr.ecr.eu-west-1.amazonaws.com
NAME=lr-integration-test
VERSION=0.0.1A

VOL_OPTS=-v=${PWD}/features:/app/features:ro -v=${PWD}/specs:/app/specs:ro -v=${PWD}/lib:/app/lib:ro

RUN_OPTS=--name ${NAME} -it --rm -e LR_URL=${LR_URL} ${VOL_OPTS}

image:
	@docker build -t ${NAME}:${VERSION} .

release:
	@docker tag ${NAME}:${VERSION} ${REGISRTY}/${IMAGE}:${VERSION}
	@docker push ${REGISRTY}/${IMAGE}:${VERSION}

install:
	@docker pull ${REGISRTY}/${NAME}:${VERSION} ${IMAGE}:${VERSION}
	@docker tag ${REGISRTY}/${NAME}:${VERSION} ${IMAGE}:${VERSION}

headless:
	@docker run ${RUN_OPTS} -e HEADLESS=1 ${NAME}:${VERSION}

gui:
	@docker run ${RUN_OPTS} -e DISPLAY=${DISPLAY} ${NAME}:${VERSION}
