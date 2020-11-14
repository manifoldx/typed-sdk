
.PHONY: 

VERSION := $(shell node -p "require('../package.json').version")

build: Dockerfile
	@echo $(VERSION) > version.txt
	@docker build -t manifold-sdk-js-doc:$(VERSION) .
	@docker tag manifold-sdk-js-doc:$(VERSION) manifold-sdk-js-doc

release: build
	@docker tag manifold-sdk-js-doc:$(VERSION) $(REGISTRY_URL)manifold-sdk-js-doc:$(VERSION)
	@docker push $(REGISTRY_URL)manifold-sdk-js-doc:$(VERSION)

all: clean build
	@docker-compose up -d

clean:
	@docker-compose down
