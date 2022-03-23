FROM ubuntu:18.04

ARG NODE_VERSION="14.15.1"

ARG user="jenkins-agent"

ARG gid="1000"

ARG uid="1000"

ARG group="jenkins-agent"

ENV JENKINS_AGENT_HOME="/home/${user}"

USER root

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

RUN  apt-get update && \
     apt-get install -y curl && \
     apt-get install -y unzip && \ 
     apt-get install --no-install-recommends -y openssh-server git-lfs && \
     rm -rf /var/lib/apt/lists/*

# install node.js
RUN  curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash && \
     . /root/.nvm/nvm.sh && \
     export NVM_DIR="/home/${user}/.nvm" && \
     mv /root/.nvm /home/${user}/.nvm && \
     mkdir /home/${user}/.nvm/versions && \
     nvm install ${NODE_VERSION} && \
     export PATH="/home/${user}/.nvm/versions/${NODE_VERSION}/bin:${PATH}" && \
     echo "export PATH=${PATH}" >> /home/${user}/.bashrc 

# install jdk-11
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get install -y openjdk-11-jdk

# install aws-cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    aws/install 

# setup SSH server
RUN sed -i /etc/ssh/sshd_config \
        -e 's/#PermitRootLogin.*/PermitRootLogin no/' \
        -e 's/#RSAAuthentication.*/RSAAuthentication yes/'  \
        -e 's/#PasswordAuthentication.*/PasswordAuthentication no/' \
        -e 's/#SyslogFacility.*/SyslogFacility AUTH/' \
        -e 's/#LogLevel.*/LogLevel INFO/' && \
    mkdir /var/run/sshd

RUN chown -R ${user}:${user} /home/${user}

COPY setup-sshd /usr/sbin/setup-sshd

EXPOSE 22

CMD [ "bash" ,"/usr/sbin/setup-sshd" ]

