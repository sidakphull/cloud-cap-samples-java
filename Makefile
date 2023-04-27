
DOCKER_ACCOUNT=cap-dev.common.repositories.cloud.sap/sidak/mt/java


build-sidecar:
	pack build bookshop-sidecar --path mtx/sidecar/gen --buildpack gcr.io/paketo-buildpacks/nodejs --builder paketobuildpacks/builder:base --env BP_NODE_RUN_SCRIPTS=""
	docker tag bookshop-sidecar:latest $(DOCKER_ACCOUNT)/bookshop-sidecar:latest

build-srv:
	pack build bookshop-srv --path srv/target/*-exec.jar --buildpack gcr.io/paketo-buildpacks/sap-machine --buildpack gcr.io/paketo-buildpacks/java --builder paketobuildpacks/builder:base --env SPRING_PROFILES_ACTIVE=cloud --env BP_JVM_VERSION=17
	docker tag bookshop-srv:latest $(DOCKER_ACCOUNT)/bookshop-srv:latest

build-uiimage:
	pack build bookshop-approuter --path app --buildpack gcr.io/paketo-buildpacks/nodejs --builder paketobuildpacks/builder:base --env BP_NODE_RUN_SCRIPTS=""
	docker tag bookshop-approuter:latest $(DOCKER_ACCOUNT)/bookshop-approuter:latest

push-images: build-sidecar build-srv build-uiimage
	docker push $(DOCKER_ACCOUNT)/bookshop-sidecar:latest
	docker push $(DOCKER_ACCOUNT)/bookshop-srv:latest
	docker push $(DOCKER_ACCOUNT)/bookshop-approuter:latest