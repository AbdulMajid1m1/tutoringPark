const mysql = require('mysql');
const db = require('../middlewares/connections');

var discs =
[{
    url: "images/icons/ico_4.png",
    title: "Beyond the textbook",
    value: "The time for one- size - fits - all textbooks is over.We use sophisticated data to select from hundreds of digitized lessons and deliver exactly what you need, when you need it.",
},
{
    url: "images/icons/ico_9.png",
    title: "Tracking and transparency",
    value: "You’ll receive detailed lesson notes, homework stats, and practice exam reports every step of the way. Plus, our online portal will keep you in the loop.",
},
{
    url: "images/icons/ico_6.png",
    title: "Easy to use",
    value: "The material is hard enough to master. Make tutoring easy. With Tutoring Park, connecting with your tutor is as simple as opening your laptop.",
},
{
    url: "images/icons/ico_8.png",
    title: "The best tutors and expert support",
    value: "Your personal dream team includes a stellar tutor and a program manager to ensure your success. The tutor helps you master the material; your program manger helps make sense of the rest (new digital tests, super scoring, and test- optional policies).",
},];


var testimonials=  function (){
    var fetch = "SELECT * FROM testimonials";
    // var count = "SELECT Count(*) FROM   testimonials ";
   return new Promise(resolve => {
    // db.query(count, function (err, result) { tLength = result[0]['Count(*)']; });
    db.db.query(fetch, function (err, result)  {
        if (err) return null;
    //   console.log(result[0].name);
        return result;
    });
    resolve();
});
    
}




function course(course){


}



module.exports={discs,testimonials};