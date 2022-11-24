const sql = require('../connections');
const paypal = require('paypal-rest-sdk');
let mail = require('../mailer');
const db = sql.db;


    // require('dotenv').config();
 


// paypal.configure({
//     'mode': process.env.PAYPAL_MODE,
//     'client_id': process.env.PAYPAL_CLIENT_ID,
//     'client_secret': process.env.PAYPAL_CLIENT_SECRET
// });

// const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY)


// paypal.configure({
//     'mode': "live", //sandbox or live
//     'client_id': "EDZRNbkj_vFgp4diOKDTWsLjHluQUX-E83tFjesakL3oewuowhgrg1dT-eQHh0JeHg2xpjy4gDMJZBF5",
//     'client_secret': "AVCR4UCkbCsH06xE5aYbZBAE84BpGf57T5DD8fjOkxSGKNi9R05S7vfrfYtvMfmacayvs6d35MykTE8A"
// });

const stripe = require('stripe')("sk_test_51LM4zTDQ6EmBlQnomUAssNHLp4tbJyosnMrnzJ4a748YBMmLuYxif4lkd7yyxLcdEmBNR79sXRi38OPEFiAsUm7U0076HA7xvL")


  









const randomString = (length = 8) => {
    return Math.random().toString(16).substr(2, length);
};














var form = async function (req, res) {


    var fetch = `SELECT * FROM courses`;
    db.query(fetch, function (err, result) {
        if (err) {res.send(err); }
        else {
            
            res.render("partials/payment/payment_form", { courses: result, message: " " });

        }

    });




}














var pay = function (req, res) {
    var name = req.body.name;
    var email = req.body.email;



    var methodType = req.body.method;
    console.log(`methodType:${methodType}`);

    // var jsonCourse = JSON.parse(req.body.course);
    var ammount;

    let sql = `INSERT INTO user (name, email, whatsapp,user_name,password,course,course_id,country,city,im) VALUES ("${name}", "${email}", "0000000","userName","password","default","0","default","default", "hero")`;

    db.query(sql, (err, result) => {
        if (err) { console.log(err); }
        else {



            if (req.body.method == 'paypal') {

//              
res.render('partials/payment/paypal',{name:req.body.name, amount:req.body.amount,email:req.body.email});








            } else {

                ammount = req.body.amount;


                try {
                    stripe.customers.create({
                        name: name,
                        email: email,
                        source: req.body.stripeToken,


                    }).then(customer => stripe.charges.create(

                        {
                            amount: parseInt(ammount) * 100,
                            currency: 'usd',
                            customer: customer.id,
                            description: ` Amount ${ammount}$ paid! for -----  ${name} and ${email} `
                        }

                    )).then((a) => {
                        console.log(a);
                        db.query(sql, (err, result) => { if (err) res.send(err) });
                        //To Admin
                        mail.send("mail@tutoringpark.com", ['payment@tutoringpark.com','tutoring.stempark@gmail.com'], "Payment Successfull", `Amount ${ammount}$ paid! by ${name}  <br><br><ul><li><strong>Name: <strong>${name}</li><li><strong>Email: <strong>${email}</li>  </u> <br><br><a href="${a.receipt_url}">View Reciept</a>`);
                        //To User
                        mail.send("mail@tutoringpark.com", [email], "Payment Successfull", `You paid Amount ${ammount}$ for a tutor to tutoringpark.com  <br> <br><br><a href="${a.receipt_url}">View Reciept</a>`);
                        var success = { title: `Payment Successful`, details: `Amount ${ammount}$ paid! for ------   \n Thanks for using our services. ` };
                        res.redirect(`/success/${success.title}/${success.details}`);
                    })
                        .catch(err => console.log(err))
                } catch (err) { res.send(err) }





            }
        }
    });




};





var paypalSuccess = async (req, res) => {
    const payerId = req.query.PayerID;
    const paymentId = req.query.paymentId;

    const execute_payment_json = {
        "payer_id": payerId,

    };

    paypal.payment.execute(paymentId, execute_payment_json, function (error, payment) {
        if (error) {
            res.render("partials/payment/failure", { title: error.response.details[0].issue, details: error.response.message });
            // console.log(error.response.details[0].issue);
            // console.log(error.response.message);

        } else {
            // console.log(payment)
            add_Payment_details_and_notify(JSON.parse(payment.transactions[0].description).cid, payment.id, JSON.parse(payment.transactions[0].description));
            res.redirect(`success/${payment.payer.payer_info.first_name + ` ${payment.payer.payer_info.last_name}` + ' thanks for using our service'}/${JSON.parse(payment.transactions[0].description).desc}`);


        }
    });
}


function add_Payment_details_and_notify(cid, paymentId, desc) {



    let user = `SELECT * FROM user WHERE id = ${cid}`;




    db.query(user, (err, result) => {
        if (err) { res.send(err); } else {
            //send to admin
            mail.send("mail@tutoringpark.com", ['tutoring.stempark@gmail.com','payment@tutoringpark.com'], "Payment Successfull", `${desc.desc}   <br><br><ul><li><strong>Name: <strong>${result[0].name}</li><li><strong>Email: <strong>${email}</li>  </u> `);
            ///send to client
            mail.send("mail@tutoringpark.com", [result[0].email], "Payment Successfull", `${desc.desc}  <br>${paymentId}<br>Thanks for using our services.`);

        }

    });


}



















module.exports = { pay, form, paypalSuccess }










//  /// /////////////// / V1 paypal code

// const create_payment_json = {
    //                     "intent": "sale",
    //                     "payer": {
    //                         "payment_method": "paypal"
    //                     },
    //                     "redirect_urls": {
    //                         "return_url": `https://tutoringpark.com/suc`,
    //                         "cancel_url": `https://tutoringpark.com/can`
    //                     },
    //                     "transactions": [{
    //                         "item_list": {
    //                             "items": [{
    //                                 "name": `custom`,
    
    //                                 "price": `${ammount}`,
    //                                 "currency": "USD",
    //                                 "quantity": 1
    //                             }]
    //                         },
    //                         "amount": {
    //                             "currency": "USD",
    //                             "total": `${ammount}`
    //                         },
    //                         "description": `{ "cid":"${result.insertId}", "desc": "Successfully purchased -----  for ${ammount}$ by ${name} "  }`
    
    //                     }]
    //                 };
    
    
    
    //                 paypal.payment.create(create_payment_json, function (error, payment) {
    //                     if (error) {
                           
    // throw error;
    //                         // res.render('partials/payment/failure', { title: error.response.message, details: JSON.parse(error.response.details) });
    
    
    //                     } else {
    
    //                         for (let i = 0; i < payment.links.length; i++) {
    //                             if (payment.links[i].rel === 'approval_url') {
    //                                 res.redirect(payment.links[i].href);
    //                             }
    //                         }
    //                     }
    //                 });













// ///Plans payment Form
// app.get('/custom-register', function (req, res) {
//     console.log(req.session
//     )
//     var fetch = "SELECT * FROM courses";
//     db.query(fetch, function (err, result) {
//         if (err) { res.send(err); }
//         else {
//             let checkUser = `SELECT COUNT(*) FROM user WHERE user_name='${req.session.userName}'`;
//             db.query(checkUser, function (err1, rslt) {
//                 if (err1) { res.send(err)1; }
//                 else {

//                     if (rslt[0]['COUNT(*)'] > 0) {
//                         res.render('partials/payment/login_and_custom_pay', { courses: result, message: " " });


//                     } else {
//                         res.render('partials/payment/register_and_custom_pay', { courses: result, message: " " });

//                     }
//                 }
//             });


//         }
//     });



// })

///Charge card and register for a course
// app.post('/pay-card', (req, res) => {

//     var name = req.body.name;
//     var email = req.body.email;
//     var whatsapp = req.body.phone;
//     // var heard = req.body.heard;
//     var im = req.body.im;
//     var first = Math.round(Math.random() * (90000 - 1000) + 1000);
//     var second = Math.round(Math.random() * (90000 - 1000) + 1000);
//     //can be plan or custom method
//     // plan: is use for buying a specific plan in form
//     // custom: is use for buying number of hours in form
//     var formMethod = req.body.methodType;
//     console.log(formMethod)
//     var jsonCourse, courseName, courseId, planSelect, ammount;


//     const userName = `${name.split(/[, ]+/)[0]}-${first}-${second}`;
//     // console.log(`UserName:${userName}`);
//     const password = randomString(20);
//     // console.log(`password:${password}`);

//     if (formMethod === 'plan') {
//         jsonCourse = JSON.parse(req.body.course);
//         courseName = jsonCourse.abbreviation;
//         courseId = jsonCourse.id;

//         planSelect = JSON.parse(req.body.plan).plan;
//         ammount = JSON.parse(req.body.plan).price;
//         // console.log(`ammount:${ammount}`);
//         // console.log(`planSelect:${planSelect}`);

//         let sql = `INSERT INTO user (name, email, whatsapp,user_name,password,course,course_id , im) VALUES ("${name}", "${email}", "${whatsapp}","${userName}","${password}","${courseName}","${courseId}", "${im}")`;

//         try {
//             stripe.customers.create({
//                 name: name,
//                 email: email,
//                 source: req.body.stripeToken,


//             }).then(customer => stripe.charges.create({
//                 amount: ammount * 100,
//                 currency: 'usd',
//                 customer: customer.id,
//                 description: ` Successfully purchased ${courseName} ${planSelect} plan for ${ammount}$ by ${userName}`
//             })).then((a) => {
//                 console.log(a);
//                 db.query(sql, (err, result) => {
//                     if (err) { console.log(err); }
//                     else { console.log(result); }
//                 });
//                 mail.send("test@kateintl.com", [email], "Payment Successfull", `You have successfully purchased ${courseName} ${planSelect} plan for ${ammount}$ <br> Thanks for using our services.<br><br><h3>Your Credentials</h3><ul><li><strong>USERNAME: </strong>${userName}</li><li><strong>PASSWORD: </strong>${password}</li></ul><br>Don't Share these credentials to anyone else you don't know.<br><br><a href="${a.receipt_url}">View Reciept</a>`);
//                 var success = { title: `Payment Successful`, details: `You have successfully purchased ${courseName}  ${planSelect} plan for ${ammount}$ \n Thanks for using our services. \n We have Sent you a USERNAME AND PASSWORD to your Email, Use them to see your progress` };
//                 res.redirect(`/success/${success.title}/${success.details}`);
//             })
//                 .catch(err => console.log(err))
//         } catch (err) { res.send(err) }

//     }
//     else if (formMethod == 'custom') {
//         ammount = req.body.amount;
//         jsonCourse = JSON.parse(req.body.course);
//         courseName = jsonCourse.abbreviation;
//         courseId = jsonCourse.id;




//         let sql = `INSERT INTO user (name, email, whatsapp,user_name,password,course,course_id , im) VALUES ("${name}", "${email}", "${whatsapp}","${userName}","${password}","${courseName}","${courseId}", "${im}")`;

//         try {
//             stripe.customers.create({
//                 name: name,
//                 email: email,
//                 source: req.body.stripeToken,


//             }).then(customer => stripe.charges.create(

//                 {
//                     amount: parseInt(ammount) * 100,
//                     currency: 'usd',
//                     customer: customer.id,
//                     description: ` Amount ${ammount}$ paid! for ${courseName} single session by ${userName} `
//                 }

//             )).then((a) => {
//                 console.log(a);
//                 db.query(sql, (err, result) => { if (err) res.send(err) });
//                 mail.send("test@kateintl.com", [email], "Payment Successfull", `Amount ${ammount}$ paid! for ${courseName} single session by ${userName}  <br> Thanks for using our services.<br><br><h3>Your Credentials</h3><ul><li><strong>USERNAME: </strong>${userName}</li><li><strong>PASSWORD: </strong>${password}</li></ul><br>Don't Share these credentials to anyone else you don't know.<br><br><a href="${a.receipt_url}">View Reciept</a>`);
//                 var success = { title: `Payment Successful`, details: `Amount ${ammount}$ paid! for ${courseName} single session   \n Thanks for using our services. \n We have Sent you a USERNAME AND PASSWORD to your Email, Use them to track your progress` };
//                 res.redirect(`/success/${success.title}/${success.details}`);
//             })
//                 .catch(err => console.log(err))
//         } catch (err) { res.send(err) }


//     }



// })


















// app.post('/pay-paypal', (req, res) => {


//     var name = req.body.name;
//     var email = req.body.email;
//     var whatsapp = req.body.phone;
//     // var heard = req.body.heard;
//     var im = req.body.im;
//     var first = Math.round(Math.random() * (90000 - 1000) + 1000);
//     var second = Math.round(Math.random() * (90000 - 1000) + 1000);
//     var methodType = req.body.methodType;
//     console.log(`methodType:${methodType}`);
//     const userName = `${name.split(/[, ]+/)[0]}-${first}-${second}`;
//     // console.log(`UserName:${userName}`);
//     const password = randomString(20);
//     // console.log(`password:${password}`);
//     var jsonCourse = JSON.parse(req.body.course);
//     var courseName, courseId, ammount, planSelect;



//     if (methodType === "plan") {


//         courseName = jsonCourse.abbreviation;
//         courseId = jsonCourse.id;

//         planSelect = JSON.parse(req.body.plan).plan;
//         ammount = JSON.parse(req.body.plan).price;

//         console.log(`ammount:${ammount}`);
//         console.log(`planSelect:${planSelect}`);

//         let sql = `INSERT INTO user (name, email, whatsapp,user_name,password,course,course_id , im) VALUES ("${name}", "${email}", "${whatsapp}","${userName}","${password}","${courseName}","${courseId}", "${im}")`;

//         let clientId;
//         let tempId;

//         db.query(sql, (err, result) => {
//             if (err) { console.log(err); } else {
//                 console.log(`user:${result.insertId}`);
//                 clientId = result.insertId;
//                 let tempPurchase = `INSERT INTO temp_purchases (user_id,course_id,plan,course_duration,course_duration_left,payment_id,payment_method,other) VALUES (${result.insertId}, ${courseId}, "custom","${JSON.parse(req.body.plan).hours}","${JSON.parse(req.body.plan).hours}"," c ", "paypal"," c ")`;

//                 db.query(tempPurchase, (err1, result1) => {
//                     if (err1) { console.log(err1); } else {


//                         const create_payment_json = {
//                             "intent": "sale",
//                             "payer": {
//                                 "payment_method": "paypal"
//                             },
//                             "redirect_urls": {
//                                 "return_url": "http://localhost:3000/suc",
//                                 "cancel_url": "http://localhost:3000/can"
//                             },
//                             "transactions": [{
//                                 "item_list": {
//                                     "items": [{
//                                         "name": `${courseName}`,

//                                         "price": `${ammount}`,
//                                         "currency": "USD",
//                                         "quantity": 1
//                                     }]
//                                 },
//                                 "amount": {
//                                     "currency": "USD",
//                                     "total": `${ammount}`
//                                 },
//                                 // "description": `Successfully purchased ${courseName} ${planSelect} plan for ${ammount}$ by ${userName}`
//                                 "description": `{ "cid":"${result.insertId}", "tempId": "${result1.insertId}", "desc": "Successfully purchased ${courseName}  ${planSelect} plan for ${ammount}$ by ${userName}}" }`
//                             }]
//                         };


//                         //   console.log(JSON.stringify(create_payment_json));
//                         paypal.payment.create(create_payment_json, function (error, payment) {
//                             if (error) {
//                                 console.log(JSON.stringify(error));
//                                 res.render('partials/payment/failure', { title: error.response.message, details: error.response.details[0].issue });
//                             } else {

//                                 for (let i = 0; i < payment.links.length; i++) {
//                                     if (payment.links[i].rel === 'approval_url') {
//                                         res.redirect(payment.links[i].href);
//                                     }
//                                 }
//                             }
//                         });
//                     }
//                 });
//             }
//         });





//     } else if (methodType === "custom") {
//         var hours = req.body.hours;
//         ammount = req.body.amount;
//         jsonCourse = JSON.parse(req.body.course);
//         courseName = jsonCourse.abbreviation;
//         courseId = jsonCourse.id;

//         console.log(`ammount:${ammount}`);
//         // // console.log(`planSelect:${planSelect}`);
//         let sql = `INSERT INTO user (name, email, whatsapp,user_name,password,course,course_id , im) VALUES ("${name}", "${email}", "${whatsapp}","${userName}","${password}","${courseName}","${courseId}", "${im}")`;

//         let clientId;
//         let tempId;

//         db.query(sql, (err, result) => {
//             if (err) { console.log(err); } else {
//                 console.log(`user:${result.insertId}`);
//                 clientId = result.insertId;
//                 let tempPurchase = `INSERT INTO temp_purchases (user_id,course_id,plan,course_duration,course_duration_left,payment_id,payment_method,other) VALUES (${result.insertId}, ${courseId}, "custom","${hours}","${hours}"," c ", "paypal"," c ")`;

//                 db.query(tempPurchase, (err1, result1) => {
//                     if (err1) { console.log(err1); } else {
//                         console.log(`temp:${result1.insertId}`);
//                         const create_payment_json = {
//                             "intent": "sale",
//                             "payer": {
//                                 "payment_method": "paypal"
//                             },
//                             "redirect_urls": {
//                                 "return_url": "http://localhost:3000/suc",
//                                 "cancel_url": "http://localhost:3000/can"
//                             },
//                             "transactions": [{
//                                 "item_list": {
//                                     "items": [{
//                                         "name": `${courseName}`,

//                                         "price": `${ammount}`,
//                                         "currency": "USD",
//                                         "quantity": 1
//                                     }]
//                                 },
//                                 "amount": {
//                                     "currency": "USD",
//                                     "total": `${ammount}`
//                                 },
//                                 "description": `{ "cid":"${result.insertId}", "tempId": "${result1.insertId}", "desc": "Successfully purchased ${courseName} ${hours}Hours for ${ammount}$ assigned to ${userName}" }`

//                             }]
//                         };


//                         //   console.log(JSON.stringify(create_payment_json));
//                         paypal.payment.create(create_payment_json, function (error, payment) {
//                             if (error) {
//                                 console.log(error);

//                                 res.render('partials/payment/failure', { title: error.response.message, details: error.response.details[0].issue });


//                             } else {

//                                 for (let i = 0; i < payment.links.length; i++) {
//                                     if (payment.links[i].rel === 'approval_url') {
//                                         res.redirect(payment.links[i].href);
//                                     }
//                                 }
//                             }
//                         });
//                     }







//                 });
//             }

//         });



//     }




// });



///Plans payment Form
// app.get('/register', function (req, res) {

//     var fetch = "SELECT * FROM courses";
//     db.query(fetch, function (err, result) {
//         if (err) { res.send(err); }
//         else {
//             let checkUser = `SELECT COUNT(*) FROM user WHERE user_name='${req.session.userName}'`;
//             db.query(checkUser, function (err1, rslt) {
//                 if (err1) { res.send(err)1; }
//                 else {

//                     if (rslt[0]['COUNT(*)'] > 0) {

//                         res.render("partials/payment/login_and_pay", { courses: result, message: " " });
//                     } else {

//                         res.render("partials/payment/register_and_pay", { courses: result, message: " " });
//                     }
//                 }
//             });
//         }

//     });



// })
