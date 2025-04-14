const mysql = require('mysql2');
const router = require('../routes/auth');
require('dotenv').config();

// Create connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'rootroot', // ❌ empty: update this
    database: 'flutter_login_app'
});


// Connect
connection.connect((err) => {
    if (err) {
        console.error('Database connection failed: ', err);
        return;
    }
    console.log('Connected to MySQL database');

});

module.exports = connection;