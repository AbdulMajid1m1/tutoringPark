const express = require('express');
const app = express();
const jwt = require('jsonwebtoken');
const async = require('async');
const multer = require('multer');
const path = require('path');
const session = require('express-session');
const sql = require('./views/middlewares/connections');
const gets = require('./views/middlewares/routes/gets');
const posts = require('./views/middlewares/routes/posts');
const payment = require('./views/middlewares/routes/payments');
// const paypal = require('@paypal/checkout-server-sdk');


app.use(session({
    secret: 'secret',
    originalMaxAge: 60 * 60 * 1000,
    resave: true,
    saveUninitialized: true,
    cookie: {
        maxAge: 1000 * 60 * 60 * 24 * 365 * 0.4
    }
},


));


const bodyparser = require('body-parser');
const { stringify } = require('querystring');
app.use(express.static(path.join(__dirname, './views')));
app.set("view engine", "ejs");
const upload = multer({ dest: 'uploads/' });
const db = sql.db;


const PORT = process.env.PORT || 3000;

app.use(bodyparser.json())
app.use(bodyparser.urlencoded({ extended: false }))


/////////////////////////// G E T   R O U T E S /////////////////////
app.get('/', gets.index);
app.get('/privacy-policy', gets.privacy_policy)
app.get('/tutors', gets.tutors)
app.get('/terms-conditions', gets.terms_condition)
app.get('/course/:course', gets.course)
app.get('/mailbox', gets.mailbox);
app.get('/how-it-works', gets.how_it_works);
app.get('/pricing', gets.pricing);


///////////////////////////////////////////////////
//////////////////////////M A I L E R/////////////////////
/////////////////////////////////////////////////

///message to admin from index
app.post('/send', posts.sendMessage);
///message to admin from course
app.post('/course/send', posts.sendMessage);
///message to admin from tutors
app.post('/tutors/send', posts.sendMessage);
///message to admin from How-it-Works
app.post('/how-it-works/send', posts.sendMessage);
///message to admin from PRICING
app.post('/pricing/send', posts.sendMessage);
///////////////////////////////////////////////////
//////////////////////////S U B S C R I B T I O N/////////////////////
/////////////////////////////////////////////////

app.post('/subscribe', posts.subscribe);
app.post('/tutor-register', posts.tutorRegister);

app.get('/subscribe-verification/:email/:token', gets.subscriber_verification);



///////////////////////////////////////////////////
//////////////////////////P A Y M E N T S/////////////////////
//////////////////////////////////////////////////

app.get('/payment-form', payment.form);
app.post('/pay', payment.pay);
app.get('/suc', payment.paypalSuccess);
app.get('/can', (req, res) => res.send('Cancelled'));
app.get('/success/:title/:details', gets.success);


///////////////////////////////////////
////////////////// A U T H E N T I C A T I O N //////////////////
//////////////////////////////////////

/// signIn 
// app.post('/signIn', posts.sigin);
// app.post('/auth', posts.auth);


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////// S T U D E N T S  D A S H B O A R D //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

app.get('/pio', function (req, res) {
    res.render('partials/payment/paypal');
}

);



module.exports = { db };
app.listen(PORT, () => console.log(`Express server currently running on port ${PORT}`));