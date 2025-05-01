.PHONY: build image

DOCKER_TAG=ghcr.io/boxofrad/teleport-sigstore-demo:compromised

build:
	GOOS=linux go build -o build/demo .

image:
	docker build --platform linux/arm64 . -t $(DOCKER_TAG)
	docker push $(DOCKER_TAG)
