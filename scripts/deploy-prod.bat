@echo off
echo 🚀 Starting Production Deployment...
echo ======================================

docker-compose -f docker-compose.prod.yml pull
docker-compose -f docker-compose.prod.yml down
docker-compose -f docker-compose.prod.yml up -d

echo 🎉 Production deployment completed!
echo.
echo 📊 Access Points:
echo    Frontend:    http://localhost:80
echo    Backend API: http://localhost:3001/health
echo    Auth API:    http://localhost:3002/health
echo    User API:    http://localhost:3003/health
echo    Order API:   http://localhost:3004/health
echo.
echo 🔍 Check service logs: docker-compose -f docker-compose.prod.yml logs
echo 🛑 Stop services: docker-compose -f docker-compose.prod.yml down
