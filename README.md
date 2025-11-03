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
##  Issues & Fixes

| **Issue** | **Cause** | **Resolution** |
|----------|-----------|----------------|
| `Could not resolve hostname nodejs-agent` | Agent container wasn’t connected to the same Docker network as Jenkins | Connected `nodejs-agent` to `jenkins-net` using `docker network connect` |
| SSH prompts for password | Public key wasn’t installed on the agent container | Copied `.pub` file to `/home/jenkins/.ssh/authorized_keys` and set correct permissions |
| Jenkins UI: `Authentication failed` | Jenkins couldn’t read or use the private key correctly | Converted key to PEM format using `ssh-keygen -p -m PEM` and pasted it directly into Jenkins credentials |
| No “From Jenkins master” option in credentials | Jenkins UI limitation or plugin version | Used “Enter directly” and pasted PEM-formatted private key |
| Jenkins tries to connect to `localhost` | Incorrect hostname in agent config | Updated agent host to `nodejs-agent` in Jenkins UI |
| SSH key rejected despite manual SSH working | Key format mismatch or incorrect credential reference | Recreated credential with PEM key and verified correct credential ID in agent config |
| SSH warning: Host keys not verified | Default verification strategy is insecure | Optionally changed to “Manually trusted key verification” or “Known hosts file verification” |
| Agent container not listed in `docker network inspect` | Container wasn’t attached to `jenkins-net` | Verified and reconnected using `docker network connect` |
| Jenkins can’t access private key file | File permissions or ownership incorrect | Set `chmod 600` and `chown jenkins:jenkins` on `/var/jenkins_home/.ssh/jenkins-key` |

## Setup Steps

### 1. Create Docker Network and jenkins Initial setup

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

### 4. Copy Private Key to Jenkins
docker cp /c/jenkins-keys/Nodejs-agent-key jenkins:/var/jenkins_home/.ssh/jenkins-key
docker exec -it jenkins bash
chmod 600 /var/jenkins_home/.ssh/jenkins-key
chown -R jenkins:jenkins /var/jenkins_home/.ssh

### 5. Copy Public Key to Agent
docker cp /c/jenkins-keys/Nodejs-agent-key.pub nodejs-agent:/home/jenkins/.ssh/authorized_keys
docker exec -it nodejs-agent bash
chmod 600 /home/jenkins/.ssh/authorized_keys
chown -R jenkins:jenkins /home/jenkins/.ssh

### 6.docker exec -it jenkins bash
ssh -i /var/jenkins_home/.ssh/jenkins-key jenkins@nodejs-agent





