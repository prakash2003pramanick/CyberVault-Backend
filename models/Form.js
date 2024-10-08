const mongoose = require('mongoose');

const FormSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String },
  created_at: { type: Date, default: Date.now },
});

module.exports = mongoose.model('Form', FormSchema);
