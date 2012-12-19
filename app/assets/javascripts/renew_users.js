$(document).ready(function(){
    $('#btnRenewUser').click(function(event){
        stripeRenew();
        return false;
    });
});

function stripeRenew(){
    Stripe.setPublishableKey($('#stripe_pk').val());
    Stripe.createToken({
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        exp_month: $('#card_month').val(),
        exp_year: $('#card_year').val()
    }, stripeRenewHandler);
}

function stripeRenewHandler(status, response){
    if (response.error){
        alert(response.error.message)
    }else{
        var form$ = $('#renew_users');
        var token = response['id'];
        form$.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
        form$.get(0).submit();
    }
}