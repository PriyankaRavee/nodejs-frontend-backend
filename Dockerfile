FROM node:18

# Install Java and Docker CLI
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    openjdk-11-jdk && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    apt-get clean

# Create Jenkins workspace directory
RUN mkdir -p /home/jenkins/agent
WORKDIR /home/jenkins/agent

# Add Jenkins agent JAR support
RUN curl -o agent.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/3102/remoting-3102.jar

# Set permissions
RUN chmod 755 agent.jar