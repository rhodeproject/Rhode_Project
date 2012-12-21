$(document).ready(function(){
    $('#btnRenewUser').click(function(event){
        $("#cc_errors").remove();
        removeInputNames();
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
        $('#user_renew_main').append('<div id="cc_errors">'+ response.error.message +'</div>');
        $('#cc_errors').addClass("alert").addClass("alert-error").addClass('span5');
    }else{
        var form$ = $('#renew_users');
        var token = response['id'];
        form$.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
        form$.get(0).submit();
    }
}
