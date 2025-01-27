const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
// Load environment variables
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Enable CORS for all routes
app.use(cors());

// Middleware to parse JSON
app.use(express.json());

// Connect to MongoDB Atlas
mongoose.connect(process.env.MONGODB_URI).then(() => {
  console.log('Connected to MongoDB Atlas');
}).catch((error) => {
  console.error('Error connecting to MongoDB Atlas:', error);
});

// Define a schema and model
const testSchema = new mongoose.Schema({
  message: String,
});

const Test = mongoose.model('Test', testSchema); 

// Basic route
app.get('/', (req, res) => {
  console.log('Basic route hit');
  res.json({ message: 'Stack-With-ECR-Fixing-Healthcheck-Issue - Hello World' });
});

// healthcheck endpoint
app.get('/health', (req, res) => {
  console.log('Healthcheck endpoint hit');
  res.status(200).json({ message: 'Stack-With-ECR-Fixing-Healthcheck-Issue - Server is healthy' });
});

// Route to get all documents
app.get('/test', async (req, res) => {
  console.log('Route to get all documents hit');
  try {
    const results = await Test.find();
    res.json(results);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Route to create a new document
app.post('/test', async (req, res) => {
  console.log('Route to create a new document hit');
  const newTest = new Test({
    message: req.body.message,
  });

  try {
    const savedTest = await newTest.save();
    res.status(201).json(savedTest);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// // Route to get a document by ID
// app.get('/api/test/:id', async (req, res) => {
//   console.log('Route to get a document by ID hit');
//   try {
//     const result = await Test.findById(req.params.id);
//     if (!result) return res.status(404).json({ message: 'Document not found' });
//     res.json(result);
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// });

// // Route to update a document by ID
// app.put('/api/test/:id', async (req, res) => {
//   console.log('Route to update a document by ID hit');
//   try {
//     const updatedTest = await Test.findByIdAndUpdate(req.params.id, req.body, { new: true });
//     if (!updatedTest) return res.status(404).json({ message: 'Document not found' });
//     res.json(updatedTest);
//   } catch (error) {
//     res.status(400).json({ message: error.message });
//   }
// });

// Route to delete a document by ID
app.delete('/api/test/:id', async (req, res) => {
  console.log('Route to delete a document by ID hit');
  try {
    const deletedTest = await Test.findByIdAndDelete(req.params.id);
    if (!deletedTest) return res.status(404).json({ message: 'Document not found' });
    res.json({ message: 'Document deleted' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
}); 