
const jwt = require('jsonwebtoken');
var async = require('async');
const sql = require('../connections');
var db = sql.db;
let models = require('../models');
let mail = require('../mailer');

var index = async (req, res) => {
    var testimonials = `SELECT * FROM testimonials`;
    var courses = `SELECT * FROM courses`;
    var data = {};

    async.parallel([
        function (p) {
            db.query(testimonials, function (err, result) {

                if (err) return p(err);
                data.testimonials = result;
                p();
            });
        },
        function (p) {
            db.query(courses, function (err, result) {

                if (err) return p(err);
                data.courses = result;
                p();
            });
        },



    ], function (err) {
        if (err) res.send(err);
        res.render('index', { discriptions: models.discs, courses: data.courses, testimonials: data.testimonials, contact: { success: false, message: ' ', } });

    });





};








var course = function (req, res) {

    var course = `SELECT * FROM courses WHERE abbreviation="${(req.params.course).toUpperCase()}"`;
    var courses = `SELECT * FROM courses`;
    let data = {};
    async.parallel([
        function (p) {
            db.query(course, function (err, result) {

                if (err) return p(err);
                data.course = result[0];
                p();
            });
        },
        function (p) {
            db.query(courses, function (err, result) {

                if (err) return p(err);
                data.courses = result;
                p();
            });
        },

    ], function (err) {
        if (err) res.send(err);

        res.render('widgets/courseDescription', { messages: { success: 'false', message: " " }, course: data.course, courses: data.courses });

    });









}








var terms_condition = function (req, res) {
    var courses = `SELECT * FROM courses`;
    db.query(courses, function (err, result) {
        if (err) { res.send(err); } else {
            res.render('widgets/terms-conditions', { courses: result });
        }
    });

}













var tutors = function (req, res) {

    db.query(`SELECT * FROM courses`, function (err, courses) {
        if (err) { res.send(err); } else {
            db.query(`SELECT * FROM tutors`, function (err1, tutors) {
                if (err1) { res.send(err1); } else {
                    res.render('widgets/tutorsPage', { tutors: tutors, courses: courses });
                }
            });
        }
    });

}








var privacy_policy = function (req, res) {
    var courses = `SELECT * FROM courses`;
    db.query(courses, function (err, result) {
        if (err) { res.send(err); } else {
            res.render('widgets/privacy-policy', { courses: result });
        }
    });

}









var mailbox = function (req, res) {
    res.redirect('https://server621.iseencloud.com:2096/cpsess7713455386/3rdparty/roundcube/?_task=mail&_mbox=INBOX');
}










var subscriber_verification = async (req, res) => {

    var email = req.params.email;
    var token = req.params.token;
    var verify = 1;
    let sql = `UPDATE subscribers SET verified =${verify}  WHERE email="${email}" AND token="${token}"`;
    db.query(sql, function (err, result) {
        if (err) {
            // console.log(`'record error:${err}'`);
            res.send(err);
        } else {
            // console.log(`'record inserted:${result}'`);
            //To User
            mail.send("mail@tutoringpark.com", [email], "Verification Successful", `THANK YOU ASAF! <br>Your Email has been Verified Successfully <br> <li><Strong>Locality: </Strong> ${date_time}</li><li><Strong>WebSite: </Strong> tutoringpark.com</li> `);

            res.render('widgets/successPage', { title: 'Email Verification', details: "Your Email Successfully verified THANK YOU!" });
        }

    });
}






var success = async function (req, res) {
      //send to admin
      mail.send("mail@tutoringpark.com", ['tutoring.stempark@gmail.com','payment@tutoringpark.com'], "Payment Successfull", `${req.params.details}   <br><br><ul><li><strong>Email: <strong>${req.params.title}</li>  </u> `);
      ///send to client
      mail.send("mail@tutoringpark.com", [req.params.title], "Payment Successfull", req.params.details);

    res.render('partials/payment/success', { details: req.params.details, title: req.params.title });
}



var dashboard = async (req, res) => {
    // console.log(`Dashboard:${req.session.loggedin}`);
    if (req.session.loggedIn) {
        if (req.session.role === 'student') {
            console.log(`student Dashboard: ${req.session.role}`);
            var data = {};
            async.parallel([
                function (p) {
                    db.query('SELECT * FROM courses', (err, result) => {
                        if (err) return p(err);
                        console.log(result[0].abbreviation);
                        data.courses = result;
                        p();
                    });
                }
            ],
                function (err) {
                    if (err) res.send(err);
                    console.log("students_dashboard");
                    res.render("admin/students_dashboard", { data: data });

                }

            )




        } else if (req.session.role == 'admin') { res.send('admin') }
        else { res.send('Please specify a Role in Tutoring park') }
    } else {

        res.send('not Logged In')
    }
}

var how_it_works = async (req, res) => {
    var courses = `SELECT * FROM courses`;
    db.query(courses, function (err, result) {
        if (err) { res.send(err); } else {

            res.render('widgets/how_it_works', { courses: result });
        }
    });

}


var pricing = async (req, res) => {
    var courses = `SELECT * FROM courses`;
    db.query(courses, function (err, result) {
        if (err) { res.send(err); } else {

            res.render('widgets/pricing', { courses: result });
        }
    });

}

module.exports = { index, course, success, terms_condition, tutors, privacy_policy, mailbox, subscriber_verification, dashboard, how_it_works, pricing };