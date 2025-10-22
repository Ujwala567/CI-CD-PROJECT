#!/bin/bash

set -e

echo "🚀 Starting Production Deployment..."
echo "======================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to log messages
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    error "Docker is not running. Please start Docker first."
fi

# Pull latest images
log "Pulling latest Docker images..."
docker-compose -f docker-compose.prod.yml pull

# Stop existing services
log "Stopping existing services..."
docker-compose -f docker-compose.prod.yml down

# Start services
log "Starting production services..."
docker-compose -f docker-compose.prod.yml up -d

# Wait for services to be healthy
log "Waiting for services to be healthy..."
sleep 30

# Check service health
log "Checking service health..."
services=("backend" "auth-service" "user-service" "order-service" "frontend" "db" "redis")

for service in "${services[@]}"; do
    if docker-compose -f docker-compose.prod.yml ps $service | grep -q "Up"; then
        log "✅ $service is running"
    else
        error "❌ $service failed to start"
    fi
done

# Run health checks
log "Running health checks..."
curl -f http://localhost:3001/health > /dev/null 2>&1 && log "✅ Backend health check passed" || error "Backend health check failed"
curl -f http://localhost:3002/health > /dev/null 2>&1 && log "✅ Auth service health check passed" || error "Auth service health check failed"
curl -f http://localhost:3000 > /dev/null 2>&1 && log "✅ Frontend health check passed" || error "Frontend health check failed"

echo ""
echo "🎉 Production deployment completed successfully!"
echo ""
echo "📊 Access Points:"
echo "   Frontend:    http://localhost:80 (or your domain)"
echo "   Backend API: http://localhost:3001/health"
echo "   Auth API:    http://localhost:3002/health"
echo "   User API:    http://localhost:3003/health"
echo "   Order API:   http://localhost:3004/health"
echo ""
echo "🔍 Check service logs: docker-compose -f docker-compose.prod.yml logs"
echo "🛑 Stop services: docker-compose -f docker-compose.prod.yml down"
echo ""
