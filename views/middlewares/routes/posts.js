const sql = require("../connections");
let mail = require("../mailer");
const multer = require("multer");
var async = require("async");
// const bodyParser = require('body-parser');
const db = sql.db;
// app.use(bodyParser.urlencoded({ extended: true }));
// app.use(bodyParser.json())
var Storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "views/uploads");
    //view/uplaods
  },
  filename: function (req, file, callback) {
    callback(null, "CV" + "_" + Date.now() + "_" + file.originalname);
  },
});
var upload = multer({
  storage: Storage,
}).single("file"); //Field name and max count

var date_time = new Date();
var sendMessage = async function (req, res) {
  var name = req.body.name;
  var email = req.body.email;
  var whatsapp = req.body.code + req.body.phone;
  // var heard = req.body.heard;
  var grade = req.body.grade;
  var subject = req.body.subject;
  var im = req.body.im;
  var message = req.body.message;
  var country = req.body.country;
  var city = req.body.city;
  mail.send(
    "mail@tutoringpark.com",
    ["tutoring.stempark@gmail.com", "info@tutoringpark.com","abdulmajid1m2@gmail.com"],
    `Hi Sir, I am ${name} `,
    `<b>${message}</b><br><li><strong>Whatsapp: <strong>${whatsapp}  <a href="https://api.whatsapp.com/send?phone=${whatsapp.replace(
      "+",
      ""
    )}&text=Hi ${name}!"><img src="https://tochat.be/whatsapp-icon-green.jpg" width="20px"height="20px"></a></li><li><strong>Email:${email} </strong I am </strong> ${im}</li> <li><strong> I am a student of Grade: </strong> ${grade} </li><li><strong> I wish to enroll myself in : </strong> ${subject}</li><li><strong> Adress: </strong> ${country} - ${city}</li><li><small> ${date_time}</small></li>`
  );
  // req.flash('info','Message sent');
  // res.redirect('/#message');
  res.redirect(`${req.get("referer")}#message`);
};

var subscribe = async (req, res) => {
  var email = req.body.email;
  var token = Math.random() * (3000000 - 10000) + 10000;
  let sql = `INSERT INTO subscribers (email,token) VALUES ( "${email}",${token})`;
  db.query(sql, function (err, result) {
    if (err) {
      // console.log(`'record error:${err}'`);
      res.send(err);
    } else {
      // console.log(`'record inserted:${result}'`);
      //To user
      mail.send(
        "mail@tutoringpark.com",
        [email],
        "You Have Subscribed TutoringPark",
        `Please verify your email by clicking the following link<br> <a href="https://tutoringpark.com/subscribe-verification/${email}/${token}">CONFIRM</a> `
      );
      //To admin
      mail.send(
        "mail@tutoringpark.com",
        ["tutoring.stempark@gmail.com"],
        "New Subscribetion",
        `Subscribed by ${email}`
      );

      res.redirect("/#subscribtion");
    }
  });
};

var tutorRegister = async (req, res) => {
  upload(req, res, function (err) {
    var data = req.body;
    uplaodedFile = req.file;

    if (err) {
      console.log(err);
      return res.status(400).json({ error: err });
    } else {
      let sql = `INSERT INTO tutor (FirstName,	LastName,Email,Phone,CvPath) VALUES ( "${data.fname}","${data.lname}","${data.email1}","${data.phone}","${uplaodedFile.path}")`;
      db.query(sql, function (err, result) {
        if (err) {
          res.status(400).json({ error: err });
        } else {
          mail.TutorRegisteredMail(
            "mail@tutoringpark.com",
            // ["tutoring.stempark@gmail.com"],
            ["abdulmajid1m1@gmail.com"],
            "Tutor Registeration Application",
            `New Tutor has applied for Tutoring Park <br /> <h3>Name</h3><h3>${data.fname} ${data.lname}</h3>
            <h3>Email</h3><h3>${data.email1}</h3>
            <h3>Phone Number</h3><h3>${data.phone}</h3>
            `,

            uplaodedFile
          );
          mail.send(
            "mail@tutoringpark.com",
            [data.email1],
            "Tutor Registeration Application",
            `  <h2>We appreciate your interest in Tutor Park. We'll get back to you shortly! </h2>
            `
          );
          res.redirect("/");
        }
      });
    }
  });
};

var signin = (req, res) => {
  const user = {
    email: "developer@metra.com",
    password: "kate12345",
  };
  let checkUser = `SELECT COUNT(*) FROM blog_admin_tb WHERE email_at='${user["email"]}' AND pass_at='${user["password"]}'`;
  let getAdminData = `SELECT name_at,role_at,email_at FROM blog_admin_tb WHERE email_at='${user["email"]}' AND pass_at='${user["password"]}'`;

  jwt.sign(
    user,
    "secretkey",
    // , { expiresIn: '30s' }
    (err, token) => {
      res.json({ token, user });
    }
  );

  console.log("Success");

  db.query(checkUser, (err, result) => {
    if (err) {
      res.send(err);
    } else {
      console.log(result);
      if (result[0]["COUNT(*)"] > 0) {
        res.status(200);
        db.query(getAdminData, (errr, resultdata) => {
          if (errr) {
            res.send(errr);
          } else {
            const result = {
              name: resultdata[0]["name_at"],
              role: resultdata[0]["role_at"],
            };

            jwt.sign(
              user,
              "secretkey",
              // , { expiresIn: '30s' }
              (err, token) => {
                res.json({ token, result });
              }
            );

            console.log("Success");
          }
        });
      } else {
        res.status(409);
        res.send("Email password does not Exist");
      }
    }
  });
};

var authenticate = function (request, response) {
  // Capture the input fields
  let username = request.body.username;
  let password = request.body.password;
  // Ensure the input fields exists and are not empty
  if (username && password) {
    // Execute SQL query that'll select the account from the database based on the specified username and password
    db.query(
      "SELECT * FROM user WHERE user_name = ? AND password = ?",
      [username, password],
      function (error, results, fields) {
        // If there is an issue with the query, output the error
        if (error) res.send(error);
        // If the account exists
        if (results.length > 0) {
          // Authenticate the user
          request.session.loggedIn = true;
          request.session.userName = username;
          request.session.role = results[0].role;
          request.session.userId = results[0].id;
          // Redirect to home page
          console.log(request.session);
          response.redirect("/dashboard");
          // response.render('/dashboard');
        } else {
          // response.render('/login',{message:"Enter correct UserName and password"});
        }
        response.end();
      }
    );
  } else {
    response.send("Please enter Username and Password!");
    response.end();
  }
};

module.exports = {
  sendMessage,
  subscribe,
  signin,
  authenticate,
  tutorRegister,
};
