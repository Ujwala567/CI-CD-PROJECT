const express = require('express');
const cors = require('cors');
const helmet = require('helmet');

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    service: 'deployhub-backend',
    version: '1.0.0'
  });
});

// API routes
app.get('/api/deployments', (req, res) => {
  res.json({
    deployments: [
      { id: 1, name: 'Production', status: 'running', version: 'v1.2.3' },
      { id: 2, name: 'Staging', status: 'deploying', version: 'v1.2.4' }
    ]
  });
});

// Test endpoint for frontend button - ADD THIS BEFORE app.listen()
app.get('/api/test', (req, res) => {
  res.json({
    message: 'Test! OK',
    status: 'success',
    timestamp: new Date().toISOString(),
    service: 'deployhub-backend'
  });
});

// This should be the LAST line
app.listen(PORT, () => {
  console.log(`🚀 DeployHub Backend running on port ${PORT}`);
  console.log(`📊 Health check: http://localhost:${PORT}/health`);
  console.log(`🧪 Test endpoint: http://localhost:${PORT}/api/test`);
});
