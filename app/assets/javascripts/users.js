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

    /*modal for contact form*/
    $("#contact").dialog({
        title: "Contact",
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        height: 540,
        width: 300,
        modal: true,
        buttons: [
            {
                text: "Send",
                click: function(event){
                    $(this).dialog("close");
                    sendContactAjax($("#contactName"),
                        $("#contactEmail").val,$("#contactMessage"));
                }
            },
            {
                text: "Close",
                click: function(){$(this).dialog("close")}

            }
        ]
    });
    $("#linkContact").click(function(event){
        $("#contact").dialog('open');
        return false;
    });

    $("#linkContact").popover({
    animation: true,
        placement: "top",
        title: "Contact",
        content: "Click to send club leaders a message...",
        delay: { show: 500, hide: 100 }
    });

});

function sendContactAjax(sName,sEmail,sMessage){
    $.ajax({
        type: "POST",
        url: "/contact",
        data: {contact:{name: sName,
            email: sEmail,
            message: sMessage}},
        error: function(e){
            alert('There was problem saving the session');
        },
        success: function(e){
            alert('Your Message will be sent');
        }
    });

}

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