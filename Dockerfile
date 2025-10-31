FROM node:18

# Install Docker CLI
RUN apt-get update && apt-get install -y docker.io

# Install any other tools needed (optional)
RUN apt-get install -y git curl

WORKDIR /app

# Default command keeps container running
CMD ["tail", "-f", "/dev/null"]
