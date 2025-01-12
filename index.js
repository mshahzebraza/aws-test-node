const express = require('express');
const app = express();
// Change port to use environment variable with fallback
const port = process.env.PORT || 3000;

// Middleware to parse JSON bodies
app.use(express.json());

// Basic route
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to the Express server!' });
});

// healthcheck endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ message: 'Latest - Server is healthy' });
});

// Start server
app.listen(port, '0.0.0.0', () => {
  console.log(`Server is running on http://localhost:${port}`);
}); 