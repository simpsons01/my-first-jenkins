FROM jenkins/jenkins:2.319.3-jdk11

USER root

RUN mkdir  /var/jenkins_home/.ssh && \
    ssh-keygen -t rsa -f /var/jenkins_home/.ssh/id_rsa -q -N "" && \
    chown -R jenkins:jenkins /var/jenkins_home