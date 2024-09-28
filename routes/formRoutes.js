const express = require('express');
const router = express.Router();
const formController = require('../controllers/formController');

router.post('/', formController.createForm);

// Additional routes can be added here

module.exports = router;
