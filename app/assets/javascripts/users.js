$(document).ready(function(){
    $('#tabs').tabs();
    $('#btnTabs').click(function(event){
       $('#tabs').tabs('select',1);
       return false;
    });

    $('#frmNewUser').dialog({
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        height: 500,
        width: 600,
        modal: true
    });
    $('#btnSignUp').click(function(event){
        $('#frmNewUser').dialog('open');
        return false;
    });

    $('#btnNewUser').click(function(event){
        Stripe.setPublishableKey($('#stripe_pk').val());
        Stripe.createToken({
                number: $('#card_number').val(),
                cvc: $('#card_code').val(),
                exp_month: $('#card_month').val(),
                exp_year: $('#card_year').val()
            }, stripeResponseHandler);
        return false;
    });
});


function stripeResponseHandler(status, response){
    if (response.error){
        alert(response.error.message)
    }else{
        var form$ = $('#new_user');
        var token = response['id'];
        form$.append("<input type='hidden' name='stripeToken' value='" + token + "'/>")
        form$.get(0).submit();
    }
}