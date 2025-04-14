const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth');

// Register route
router.post('/register', authController.register);

// Login route
router.post('/login', authController.login);

// Forgot password route
router.post('/forgot-password', authController.forgotPassword);

module.exports = router;