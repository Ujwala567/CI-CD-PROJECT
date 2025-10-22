#!/bin/bash
echo "🚀 Starting production deployment..."

# Build and push images
docker-compose -f docker-compose.prod.yml build

# Deploy to production
docker-compose -f docker-compose.prod.yml up -d

echo "✅ Deployment completed!"
echo "📊 Frontend: http://localhost"
echo "🔧 Backend API: http://localhost:3001"
echo "👤 Auth API: http://localhost:3002"
