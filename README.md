# 🧰 Jenkins Master-Agent Setup with Docker and SSH

This guide documents the setup of a Jenkins master-agent architecture using Docker containers and SSH-based connectivity. It includes configuration steps, common issues encountered, and their resolutions.

---

## 📦 Environment

- **Host OS**: Windows 11 (Git Bash)
- **Containers**:
  - `jenkins` (Jenkins master)
  - `nodejs-agent` (SSH-based build agent)
- **Docker Network**: `jenkins-net` (custom bridge network)
- **SSH Key Pair**:
  - Private: `/c/jenkins-keys/Nodejs-agent-key`
  - Public: `/c/jenkins-keys/Nodejs-agent-key.pub`

---

## 🚀 Setup Steps

### 1. Create Docker Network

```bash
docker network create jenkins-net# nodejs-frontend-backend

### 2. Start Jenkins Container
docker run -d --name jenkins \
  --network jenkins-net \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

### 3. Start Agent Container
docker run -d --name nodejs-agent \
  nodejs-agent-image

docker network connect jenkins-net nodejs-agent

###4. Copy Private Key to Jenkins
docker cp /c/jenkins-keys/Nodejs-agent-key jenkins:/var/jenkins_home/.ssh/jenkins-key
docker exec -it jenkins bash
chmod 600 /var/jenkins_home/.ssh/jenkins-key
chown -R jenkins:jenkins /var/jenkins_home/.ssh

###5. Copy Public Key to Agent
docker cp /c/jenkins-keys/Nodejs-agent-key.pub nodejs-agent:/home/jenkins/.ssh/authorized_keys
docker exec -it nodejs-agent bash
chmod 600 /home/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /home/jenkins/.ssh

###6.docker exec -it jenkins bash
ssh -i /var/jenkins_home/.ssh/jenkins-key jenkins@nodejs-agent



