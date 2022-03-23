create-network:
	if [ -z "$$(docker network ls | grep jenkins-network)" ]; then \
		docker network create jenkins-network; \
	fi

build-jenkins:
	if [ -z "$$(docker image ls | grep jenkins-image)" ]; then \
		docker build -t jenkins-image ./jenkins; \
	fi

delete-jenkins:
	docker image rm jenkins-image

stop-jenkins:
	if [ -n "$$(docker container ls -a | grep jenkins)" ]; then \
		docker container stop jenkins; \
	fi

start-jenkins:
	docker run \
	  -u root \
		--name jenkins \
		--rm \
		-it \
		--detach \
		--network jenkins-network \
		--publish 8080:8080 \
		--volume $$(pwd)/jenkins/volumes/jenkins_home:/var/jenkins_home \
		jenkins-image

enter-jenkins:
	docker exec -it -u jenkins jenkins /bin/bash

build-jenkins-agent:
	if [ -z "$$(docker image ls | grep docker-agent-image)" ]; then \
		docker build -t docker-agent-image ./agent; \
	fi

delete-jenkins-agent:
	docker image rm docker-agent-image

stop-jenkins-agent:
	docker container stop jenkins-agent

start-jenkins-agent:
	docker run \
	  --user root \
		--name jenkins-agent \
		--rm \
		--detach \
		--publish 2000:22 \
		--env JENKINS_AGENT_SSH_PUBKEY="$(ssh_pubkey)" \
		--volume ${HOME}/.aws:/home/jenkins/.aws \
		--network jenkins-network \
		docker-agent-image

enter-jenkins-agent:
	docker exec -it -u jenkins-agent jenkins-agent /bin/bash
 