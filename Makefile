create-network:
	docker network create jenkins-network

build-jenkins:
	docker build -t jenkins-image ./jenkins

delete-jenkins-image:
	docker image rm jenkins-image

stop-jenkins:
	docker container stop jenkins
	docker container rm jenkins

start-jenkins:
	docker run \
		--name jenkins \
		--detach \
		--network jenkins-network \
		--network-alias jenkins \
		--publish 8080:8080 \
		--volume jenkins_home:/var/jenkins_home \
		--restart unless-stopped \
		jenkins-image

enter-jenkins:
	docker exec -it -u jenkins jenkins /bin/bash

build-jenkins-agent:
	docker build -t jenkins-agent-image ./agent

delete-jenkins-agent-image:
	docker image rm jenkins-agent-image

stop-jenkins-agent:
	docker container stop jenkins-agent
	docker container rm jenkins-agent

start-jenkins-agent:
	docker run \
		--name jenkins-agent \
		--detach \
		--network jenkins-network \
		--network-alias jenkins-agent \
		--restart unless-stopped \
		--env JENKINS_AGENT_SSH_PUBKEY="$(ssh_pubkey)" \
		--cpus=$(cpu) \
		--memory=${memory} \
		--volume jenkins_agent_aws:/var/jenkins_home/.aws \ 
		jenkins-agent-image

enter-jenkins-agent:
	docker exec -it -u jenkins jenkins-agent /bin/bash
 