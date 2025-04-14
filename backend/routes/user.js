const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { authenticateToken } = require('../middleware/auth');

// Get user profile
router.get('/profile', authenticateToken, (req, res) => {
    db.query('SELECT id, email, created_at FROM users WHERE id = ?',
        [req.user.id],
        (err, results) => {
            if (err) {
                console.error(err);
                return res.status(500).json({ message: 'Server error' });
            }

            if (results.length === 0) {
                return res.status(404).json({ message: 'User not found' });
            }

            res.status(200).json({
                user: results[0]
            });
        }
    );
});

module.exports = router;