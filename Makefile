CONTROLLER_IMAGE_NAME = controller
CONTROLLER_CONTAINER_NAME = jenkins-controller
AGENT_IMAGE_NAME = agent
AGENT_CONTAINER_NAME = jenkins-agent
NETWORK_NAME = jenkins-network
ON_FAILURE_MAX_RETRY = 10

create-network:
	docker network create $(NETWORK_NAME)

build-controller:
	docker build -t $(CONTROLLER_IMAGE_NAME) ./controller

delete-controller-image:
	docker image rm $(CONTROLLER_IMAGE_NAME)

stop-controller:
	docker container stop $(CONTROLLER_CONTAINER_NAME)
	docker container rm $(CONTROLLER_CONTAINER_NAME)

start-controller:
	docker run \
		--name $(CONTROLLER_CONTAINER_NAME) \
		--detach \
		--network $(NETWORK_NAME) \
		--network-alias $(CONTROLLER_CONTAINER_NAME) \
		--publish 8080:8080 \
		--volume $$(pwd)/controller/volumes:/var/jenkins_home/ \
		--restart on-failure:$(ON_FAILURE_MAX_RETRY) \
		controller

enter-controller:
	docker exec -it -u jenkins $(CONTROLLER_CONTAINER_NAME) /bin/bash

build-agent:
	docker build -t $(AGENT_IMAGE_NAME) ./agent

delete-agent-image:
	docker image rm $(AGENT_IMAGE_NAME)

stop-agent:
	docker container stop $(AGENT_CONTAINER_NAME)
	docker container rm $(AGENT_CONTAINER_NAME)

start-agent:
	docker run \
		--name $(AGENT_CONTAINER_NAME) \
		--detach \
		--network $(NETWORK_NAME) \
		--network-alias $(AGENT_CONTAINER_NAME) \
		--restart on-failure:$(ON_FAILURE_MAX_RETRY) \
		--env JENKINS_AGENT_SSH_PUBKEY="$(ssh_pubkey)" \
		--cpus="$(cpu)" \
		--memory="${memory}" \
		$(AGENT_IMAGE_NAME)

enter-agent:
	docker exec -it -u jenkins $(AGENT_CONTAINER_NAME) /bin/bash
 