const stripe = Stripe('pk_test_51LM4zTDQ6EmBlQno0bMiGP0FXg4wq7NtFjvojszV9cqtgEPsv8gPDodumQkp8h9kKypIPzQKxl95Dgk6D6i5ZYBp00dkIfPdPj');


const elements = stripe.elements();
var style = {

    base: {

        color: "rgb(158, 181, 197)"
    },

}
const card = elements.create('card', { style });
const form = document.querySelector('form');
const errorEl = document.querySelector('#card-errors');
var currentMethod = 'paypal';
///Change Payment Method
document.getElementById('paypal').addEventListener("click", () => {
    document.getElementById('id-card').style.display = "none";
    document.getElementById('id-paypal').style.display = "block";
    document.getElementById('paypal').style.background = "#1da1f2";
    document.getElementById('paypal').style.boxShadow = "#49484871 1px 2px 4px 2px";
    document.getElementById('paypal').style.color = "white";
    document.getElementById('card').style.color = "grey";
    document.getElementById('card').style.boxShadow = "none";
    document.getElementById('card').style.background = "white";
    document.getElementById('id-method').value = 'paypal';
    currentMethod = 'paypal';


    ///create Card Credentials form
    document.getElementById('paymentCard').innerHTML = "";

    ///change form action "pay-paypal"
    document.getElementById("form").action = "pay";


    ///remove hidden input field created by runStripe()
    // var hiddenStripeInput = document.getElementById('token');
    // hiddenStripeInput.parentNode.removeChild(hiddenStripeInput);

});
document.getElementById('card').addEventListener("click", () => {
    document.getElementById('id-paypal').style.display = "none";
    document.getElementById('id-card').style.display = "block";
    document.getElementById('paypal').style.background = "white";
    document.getElementById('paypal').style.boxShadow = "none";
    document.getElementById('card').style.background = "#1da1f2";
    document.getElementById('card').style.boxShadow = "#49484871 1px 2px 4px 2px";
    document.getElementById('card').style.color = "white";
    document.getElementById('paypal').style.color = "grey";
    document.getElementById('id-method').value = 'card';

    document.getElementById("form").action = "pay";
    currentMethod = 'card';
    ///Add tag for Payment
    document.getElementById('paymentCard').innerHTML = '<div id="card-element" style="padding:2rem;font-size:1rem;border-radius: 5px; border: 0.5px solid #7b7e838a; background-color:#fffefe ;"> </div>';
    runStripe('card');
}


);
// console.log(currentMethod);



function runStripe(method) {
    if (currentMethod === 'card') {
        card.mount('#card-element');

        const stripeTokenHandler = token => {
            const hiddenInput = document.createElement('input');
            hiddenInput.setAttribute('type', 'hidden');
            // hiddenInput.setAttribute('id', 'token');
            hiddenInput.setAttribute('name', 'stripeToken');
            hiddenInput.setAttribute('value', token.id);
            form.appendChild(hiddenInput);
            // console.log(form)
            form.submit();
        }



        form.addEventListener('submit', e => {
            if (currentMethod === 'card') {
            e.preventDefault();
            stripe.createToken(card).then(res => {
                if (res.error) errorEl.textContent = res.error.message;
                else {
                    // console.log(res.token)
                    stripeTokenHandler(res.token);
                }
            })
        }
        })



    }
}


