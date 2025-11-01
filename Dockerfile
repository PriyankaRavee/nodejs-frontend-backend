FROM node:18

# Install Docker CLI and OpenSSH server
RUN apt-get update && apt-get install -y docker.io openssh-server

# Create Jenkins user
RUN useradd -m -s /bin/bash jenkins

# Set up SSH directory
RUN mkdir -p /home/jenkins/.ssh && \
    chown -R jenkins:jenkins /home/jenkins/.ssh && \
    chmod 700 /home/jenkins/.ssh

# Set password (optional for testing)
RUN echo 'jenkins:jenkins' | chpasswd

# Start SSH service
RUN mkdir /var/run/sshd
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]