build-my-jenkins-image:
	docker build -t my-jenkins-image .

create-jenkins-network:
	docker network create jenkins

delete-my-jenkins-container:
	docker container stop my-jenkins
	docker container rm my-jenkins

run-my-jenkins:
	docker run --name my-jenkins -p 8080:8080 -d --network=jenkins  my-jenkins-image