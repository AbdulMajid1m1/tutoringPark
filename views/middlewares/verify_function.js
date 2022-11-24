const jwt = require('jsonwebtoken');

const SecretKeyAPI = '1...0_Pakistani_$_i_No_one';

function verifyFunction(req, res, next) {
    const bearerHeader = req.headers['authorization'];
    console.log(bearerHeader);
    if (typeof bearerHeader !== 'undefined') {
        const bearer = bearerHeader.split(' ');
        console.log(bearer);
        //get token from array 
        const bearerToken = bearer[1];
        console.log(bearerToken);
        req.token = bearerToken;
        next();
    } else {
        console.log("in JWT");
        res.json({status:403,
        message:"Caught by Verify Function"});
     
    }

}


var verify = function(req, res, next){
	var token = req.header('x-auth');
	
    jwt.verify(token, SecretKeyAPI, function(err, decoded) {    
    if (err) {    
        res.status(401).send({message:'Please login with correct credentials'});
    } 
	 next();
  });
}

module.exports={verify};