FROM node:18

# Optional: install Docker CLI if needed
RUN apt-get update && apt-get install -y docker.io

WORKDIR /app
