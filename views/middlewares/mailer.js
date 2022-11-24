const nodemailer = require("nodemailer");
const path = require("path");

// require('dotenv').config();
//

var transporterGmail = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "youremail@gmail.com",
    pass: "yourpassword",
  },
});

// var transporterWebMail=nodemailer.createTransport({
//     host: process.env.MAILER_HOST,
//     port: process.env.MAILER_PORT,
//     secure: true,
//     auth: {
//       user: process.env.MAILER_EMAIL,
//       pass:process.env.MAILER_PASSWORD
//     }
//   });
var transporterWebMail = nodemailer.createTransport({
  host: "mail.tutoringpark.com",
  port: 465,
  secure: true,
  auth: {
    user: "mail@tutoringpark.com",
    pass: "@Mail1998",
  },
});

///Body will be html Editable
function sendGmailTo(from, to, subject, body) {
  var mailOptions = {
    from: from,
    to: to,
    subject: subject,
    html: `'<div>${body}</div>'`,
  };

  transporterGmail.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log("Email sent: " + info.response);
    }
  });
}

function send(from, to, subject, body) {
  var mailOptions = {
    from: from,
    to: to,
    subject: subject,
    html: `'<div>${body}</div>'`,
  };
  let result;
  transporterWebMail.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
      result = error;
    } else {
      console.log("Email sent: " + info);
      result = info;
    }
  });
  return result;
}
function TutorRegisteredMail(from, to, subject, body, attachFile) {
  var mailOptions = {
    from: from,
    to: to,
    subject: subject,
    html: `'<div>${body}</div>'`,
    attachments: [
      {
        filename: attachFile.filename, // <= Here: made sure file name match
        path: path.join(__dirname, `../uploads/${attachFile.filename}`), // <= Here
        contentType: "application/pdf",
      },
    ],
  };
  let result;
  transporterWebMail.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
      result = error;
    } else {
      console.log("Email sent: " + info);
      result = info;
    }
  });
  return result;
}

// transporter.sendMail(mailOptions, function (error, cb) {});

module.exports = { send, sendGmailTo, TutorRegisteredMail };
