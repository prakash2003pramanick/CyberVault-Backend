#!/bin/bash

# # Create the main directory for the backend
# mkdir -p society-website-backend

# # Navigate to the backend directory
# cd society-website-backend

# Create the directory structure
mkdir -p config
mkdir -p controllers
mkdir -p middleware
mkdir -p models
mkdir -p routes
mkdir -p utils
mkdir -p src
mkdir -p src/forms
mkdir -p src/teams

# Create the main application file
touch index.js

# Create configuration files
touch config/db.js
touch config/config.js

# Create utility files
touch utils/responseHandler.js
touch utils/validation.js

# Create middleware files
touch middleware/auth.js
touch middleware/errorHandler.js

# Create model files
touch models/Form.js
touch models/Team.js

# Create controller files
touch controllers/formController.js
touch controllers/teamController.js

# Create route files
touch routes/formRoutes.js
touch routes/teamRoutes.js

# Create the main server file
cat <<EOL > index.js
const express = require('express');
const mongoose = require('mongoose');
const formRoutes = require('./routes/formRoutes');
const teamRoutes = require('./routes/teamRoutes');
const config = require('./config/config');
const app = express();

// Middleware
app.use(express.json());

// Connect to MongoDB
mongoose.connect(config.databaseUrl, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('MongoDB connected'))
.catch(err => console.error(err));

// Routes
app.use('/api/forms', formRoutes);
app.use('/api/teams', teamRoutes);

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(\`Server is running on port \${PORT}\`);
});
EOL

# Create config/db.js
cat <<EOL > config/db.js
const mongoose = require('mongoose');
const config = require('./config');

const connectDB = async () => {
  try {
    await mongoose.connect(config.databaseUrl, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB Connected...');
  } catch (err) {
    console.error(err.message);
    process.exit(1);
  }
};

module.exports = connectDB;
EOL

# Create config/config.js
cat <<EOL > config/config.js
module.exports = {
  databaseUrl: 'mongodb://localhost:27017/societyWebsite', // Change this to your MongoDB URL
};
EOL

# Create models
cat <<EOL > models/Form.js
const mongoose = require('mongoose');

const FormSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String },
  created_at: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Form', FormSchema);
EOL

cat <<EOL > models/Team.js
const mongoose = require('mongoose');

const TeamSchema = new mongoose.Schema({
  name: { type: String, required: true },
  role: { type: String, required: true },
  created_at: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Team', TeamSchema);
EOL

# Create controllers
cat <<EOL > controllers/formController.js
const Form = require('../models/Form');

exports.createForm = async (req, res) => {
  const newForm = new Form(req.body);
  try {
    const savedForm = await newForm.save();
    res.status(201).json(savedForm);
  } catch (err) {
    res.status(500).json(err);
  }
};

// Additional form-related controllers can be added here
EOL

cat <<EOL > controllers/teamController.js
const Team = require('../models/Team');

exports.createTeam = async (req, res) => {
  const newTeam = new Team(req.body);
  try {
    const savedTeam = await newTeam.save();
    res.status(201).json(savedTeam);
  } catch (err) {
    res.status(500).json(err);
  }
};

// Additional team-related controllers can be added here
EOL

# Create routes
cat <<EOL > routes/formRoutes.js
const express = require('express');
const router = express.Router();
const formController = require('../controllers/formController');

router.post('/', formController.createForm);

// Additional routes can be added here

module.exports = router;
EOL

cat <<EOL > routes/teamRoutes.js
const express = require('express');
const router = express.Router();
const teamController = require('../controllers/teamController');

router.post('/', teamController.createTeam);

// Additional routes can be added here

module.exports = router;
EOL

# Create middleware
cat <<EOL > middleware/auth.js
// Authentication middleware
module.exports = (req, res, next) => {
  // Implement authentication logic
  next();
};
EOL

cat <<EOL > middleware/errorHandler.js
module.exports = (err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
};
EOL

# Create utils
cat <<EOL > utils/responseHandler.js
exports.sendResponse = (res, status, message, data) => {
  res.status(status).json({
    status,
    message,
    data,
  });
};
EOL

cat <<EOL > utils/validation.js
// Add validation functions
EOL

# Print completion message
echo "Directory structure for the Node.js backend of the society website created successfully!"
