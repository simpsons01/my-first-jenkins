FROM jenkins/ssh-agent:jdk11

RUN  apt-get update && \
     apt-get install -y curl && \
     apt-get install -y unzip && \
     apt-get install -y git 

# install node.js
RUN  curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
     apt-get install -y nodejs

# install aws-cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    aws/install && \
    rm -rf awscliv2.zip 

