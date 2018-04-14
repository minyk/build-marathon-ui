PWD := `pwd`
MARATHON_TAG := v1.5.8
REPOSITORY := minyk
IMAGE := marathon
TAG := ${MARATHON_TAG}-criteo

default: build

build: clean
	docker run -t --rm -v $(PWD):/build node:5.4.1 /build/build.sh
	docker build --pull . --build-arg MARATHON_TAG=${MARATHON_TAG} -t ${REPOSITORY}/${IMAGE}:${TAG} -f ./Dockerfile.build

push: build
	docker push ${REPOSITORY}/${IMAGE}:${TAG}

clean:
	rm  -f ./dist | true
	docker rmi ${REPOSITORY}/${IMAGE}:${TAG} | true
