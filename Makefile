create-network:
	docker network create jenkins-network

build-jenkins:
	docker build -t jenkins-image ./jenkins

delete-jenkins:
	docker image rm jenkins-image

stop-jenkins:
	docker container stop jenkins

start-jenkins:
	docker run \
	  --user jenkins \
		--name jenkins \
		--rm \
		--detach \
		--network jenkins-network \
		--publish 8080:8080 \
		--volume $$(pwd)/jenkins/volumes/jenkins_home:/var/jenkins_home \
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
	  --user jenkins \
		--name jenkins-agent \
		--rm \
		--detach \
		--env JENKINS_AGENT_SSH_PUBKEY="$(ssh_pubkey)" \
		--volume $$(pwd)/jenkins/volumes/jenkins-agent:/home/jenkins-agent
		--network jenkins-network \
		jenkins-agent-image

enter-jenkins-agent:
	docker exec -it -u jenkins-agent jenkins-agent /bin/bash
 