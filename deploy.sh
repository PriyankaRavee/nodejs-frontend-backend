#!/bin/bash
set -e

echo "Starting Minikube and setting up environment..."

# Start minikube if not running
if ! minikube status | grep -q "host: Running"; then
  echo "Starting Minikube..."
  minikube start
else
  echo "Minikube already running"
fi

# Enable ingress
echo "Enabling ingress addon..."
minikube addons enable ingress

# Use minikube Docker environment
echo "Using Minikube Docker environment..."
eval $(minikube docker-env)

# Build Docker image
echo "Building Docker image..."
docker build -t sample-app:latest ./backend

# Apply K8s manifests
echo "Deploying to Kubernetes..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml

# Wait for pods to become ready
echo "Waiting for pods to start..."
kubectl wait --for=condition=available --timeout=120s deployment/sample-app || true

# Get service and ingress info
echo "Getting deployment status..."
kubectl get pods
kubectl get svc
kubectl get ingress

# Show Minikube IP
echo "Minikube IP: $(minikube ip)"
echo "Setup complete! Access your app at: http://sample-app.local"
