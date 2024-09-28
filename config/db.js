const mongoose = require('mongoose');
const config = require('./config');

const connectDB = async () => {
  try {
    console.log("Connecting to the database")
    await mongoose.connect(config.databaseUrl, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB Connected...');
  } catch (err) {
    console.error(err.message);
  }
};

module.exports = connectDB;
