const mysql = require("mysql");

// require('dotenv').config();
// const db = mysql.createConnection({
//     host: process.env.DBHOST,
//     user: process.env.DBUSER,
//     password: process.env.DBPASSWORD,
//     database: process.env.DBNAME,
// });

//  Online database
// const db = mysql.createConnection({
//     host: "localhost",
//     user: 	"tutoring_park_user",
//     password: "f7Lk^aX,[gyR",
//     database: "tutoring_park_db",
// });

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "tutoring-park-db",
});

db.connect(function (err) {
  if (err) throw err;
  console.log("TUTORS Database Connected!");
});

module.exports = { db };
