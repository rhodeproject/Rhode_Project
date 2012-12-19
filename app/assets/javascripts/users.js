$(document).ready(function(){
    $('#tabs').tabs();
    $('#btnTabs').click(function(event){
       $('#tabs').tabs('select',1);
       return false;
    });
    $("#btnTabPay").click(function(event){
        var termsCheck = $("#termsYes");
        if (termsCheck.is(':checked')){
            $('#tabs').tabs('select',2);
        }
        return false;
    });
    /*disable new user button if the terms and conditions aren't checked*/
    /*disable the payment tab if the terms and conditions aren't checked*/
    /*disable the next button on the terms and conditions tab if terms and conditions aren't checked*/
    /*btnNewUser*/
    $("#tabs-3").attr('disabled', true);
    $("#btnTabPay").attr('disabled', true);
    $("#btnNewUser").attr('disabled', true);
    $("#termsYes").click(function(event){
        var thisCheck = $(this);
        if (thisCheck.is(':checked')){
           $("#btnNewUser").attr('disabled', false);
           $("#tabs-3").attr('disabled', false);
           $("#btnTabPay").attr('disabled', false);
       }else{
           $("#btnNewUser").attr('disabled', true);
           $("#tabs-3").attr('disabled', true);
           $("#btnTabPay").attr('disabled', true);
       }
    });

    $('#frmNewUser').dialog({
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        height: 600,
        width: 600,
        modal: true
    });

    $('#btnSignUp').click(function(event){
        $('#frmNewUser').dialog('open');
        return false;
    });

    $('#btnNewUser').click(function(event){
        $('#cc_new_errors').remove();
        stripePayment();
        return false;
    });
});

function stripePayment(){
    Stripe.setPublishableKey($('#stripe_pk').val());
    Stripe.createToken({
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        exp_month: $('#card_month').val(),
        exp_year: $('#card_year').val()
    }, stripeResponseHandler);
}

function stripeResponseHandler(status, response){
    if (status == 200){
        var form$ = $('#new_user');
        var token = response['id'];
        form$.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
        form$.get(0).submit();

    }else{
        $('#tabs-3').prepend('<div id="cc_new_errors">'+ response.error.message +'</div>');
        $('#cc_new_errors').addClass("alert").addClass("alert-error");
    }
}
function removeInputNames() {
    $("#card_number").removeAttr("name");
    $("#card_code").removeAttr("name");
    $("#card_year").removeAttr("name");
}