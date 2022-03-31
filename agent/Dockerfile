FROM jenkins/ssh-agent:jdk11

ENV NODE_VERSION="14.15.1"

USER root

RUN  apt-get update && \
     apt-get install -y curl && \
     apt-get install -y unzip && \
     apt-get install -y git 

# install node.js
RUN  curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash && \
     . /root/.nvm/nvm.sh && \
     export NVM_DIR="/root/.nvm" && \
     mkdir /root/.nvm/versions && \
     nvm install ${NODE_VERSION}

# install aws-cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    aws/install 

COPY init /home/jenkins/init

CMD [ "bash" ,"/home/jenkins/init" ]

