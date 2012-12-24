$(document).ready(function(){
    UserValidation();
    //btnTabs - OnClick Add Class require
    $('#tabs').tabs();
    $('#btnTabs').click(function(event){
        if (validator.numberOfInvalids() > 0){
            $('#tabs').tabs('select',0);
        }else{
            $('#tabs').tabs('select',1);
        }

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
        $('#cc_new_errors').addClass("alert").addClass("alert-error").addClass('span5');
    }
}
function removeInputNames() {
    $("#card_number").removeAttr("name");
    $("#card_code").removeAttr("name");
    $("#card_year").removeAttr("name");
}

function UserValidation(){
    /*forms validation for new user*/
    var validator = $('#new_user').validate({
        rules: {
            "user[name]": {
                required: true,
                minlength: 2
            },
            "user[email]": {
                required: true,
                email: true
            },
            "user[password]": {
                required: true,
                minlength: 6
            },
            "user[password_confirmation]": {
                equalTo: "#user_password"
            },
            card_number: {
                required: true,
                creditcard: true
            }
        }, //end of rules
        messages:{
            "user[name]": {
                required: "you need to enter a name!",
                minlength: "your name has to be at least 2 characters"
            },
            "user[email]": {
                required: "you must enter your email address!",
                email: "this must be a valid address, example: me@here.com"
            },
            "user[password]": {
                minlength: "your password must be at least 6 charaters"
            },
            "user[password_confirmation]": {
                equalTo: "not matching..."
            }
        } //end of messages
    }); //end validate new_user
}