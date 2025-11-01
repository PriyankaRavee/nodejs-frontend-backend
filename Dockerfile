# Dockerfile for jenkins-node-docker-agent
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    docker.io \
    nodejs \
    npm \
    sudo

# Create Jenkins user
RUN useradd -m -s /bin/bash jenkins && \
    echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Setup SSH
RUN mkdir /var/run/sshd
RUN mkdir -p /home/jenkins/.ssh
COPY authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.ssh && chmod 600 /home/jenkins/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]