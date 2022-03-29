create-network:
	docker network create jenkins-network

build-jenkins:
	docker build -t jenkins-image ./jenkins

delete-jenkins:
	docker image rm jenkins-image

delete-jenkins-volume:
	docker volume rm jenkins

stop-jenkins:
	docker container stop jenkins

start-jenkins:
	docker run \
		--name jenkins \
		--rm \
		--detach \
		--network jenkins-network \
		--network-alias jenkins \
		--publish 8080:8080 \
		--volume jenkins_home:/var/jenkins_home \
		--restart always \
		jenkins-image

enter-jenkins:
	docker exec -it -u jenkins jenkins /bin/bash

build-jenkins-agent:
	docker build -t jenkins-agent-image ./agent

delete-jenkins-agent:
	docker image rm jenkins-agent-image

stop-jenkins-agent:
	docker container stop jenkins-agent

start-jenkins-agent:
	docker run \
		--name jenkins-agent \
		--rm \
		--detach \
		--env JENKINS_AGENT_SSH_PUBKEY="$(ssh_pubkey)" \
		--network jenkins-network \
		--network-alias jenkins-agent \
		--restart always \
		jenkins-agent-image

enter-jenkins-agent:
	docker exec -it -u jenkins jenkins-agent /bin/bash
 