$(document).ready(function(){
    validator = UserValidation();
    //btnTabs - OnClick Add Class require
    $('#tabs').tabs();
    $('#btnTabs').click(function(event){
        $('#tabs').tabs('select',1);
       return false;
    });

    //hide cvv_help on load
    $("#cvv_help").hide();
    $("#card_code").hover(function(){
       $("#cvv_help").toggle();
    });

    $("#btnTabPay").click(function(event){
        var termsCheck = $("#termsYes");
        if (termsCheck.is(':checked')){
            $('#tabs').tabs('select',2);
        }
        return false;
    });
    //forum users class on hover
    $(".forum-users").click(function(){
       $("#show_forum_users").dialog('open');

        return false;
    });
    //users following a Forum Modal
    /**$("#show_forum_users").dialog({
        title: "users following",
        autoOpen: false,
        open: {
            affect: "fadeIn",
            duration: 500
        },
        hide:{
            effect: "fadeOut",
            duration: 500
        },
        height: 250,
        width: 500,
        modal: true,
        beforClose: function(){
            $("#show_forum_users").empty();
        }
    });
    **/
    //end users following a Forum Modal

    //charges modal
    $("#show_charge").dialog({
        title: "payment details",
        autoOpen: false,
        buttons:[
            {
                text: "Refund",
                click: function(event){
                    refundCharge($("#payId").text().substring(14));
                }
            },
            {
                text: "Close",
                click: function(events){
                    $(this).dialog("close");
                }
            }
        ],
        open: {
            effect: "fadeIn",
            duration: 500},
        hide: {
            effect: "fadeOut",
            duration: 500
        },
        height: 250,
        width: 590,
        modal: true,
        beforeClose: function(){
            $("#show_charge").empty();
        }
    });

    $(".stripe_payment").click(function(){

        $("#show_charge").dialog('open');
        getCharge($(this).text());
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
    $('#txt_referred_by').popover({
        animation: true,
        placement: "right",
        title: "Referral Email",
        content: "If someone referred you, enter their email address here",
        delay: { show: 500, hide: 100 }
    });

    $('#frmNewUser').dialog({
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        height: 620,
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


    $('#tblUsers').dataTable({
        "bRetrieve": true,
        "bStateSave": true,
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": true,
        "bInfo": true,
        "bAutoWidth": false,
        "aaSorting": [[0, "asc"]],
        "sPaginationType": "two_button",
        "sDom": "<'row-fluid'<'span10'T>r>t<'row-fluid'<'span6'i<'btn btn-mini'p>>>",
        "fnRowCallback": function(nRow, aData, iDisplayIndex){ //change the color of text based on cell content
            if (aData[3] == "no"){ //if the user is inactive change the color of the whole row to red
                $('td:eq(1)',nRow).css('color','red'); //Joined
                $('td:eq(2)',nRow).css('color','red'); //Email
                $('td:eq(3)',nRow).css('color','red'); //Active
                $('td:eq(4)',nRow).css('color','red'); //Payment_id
                $('td:eq(5)',nRow).css('color','red'); //Expiry Date
                $('td:eq(6)',nRow).css('color','red'); //Referrals
                $('td:eq(7)',nRow).css('color','red'); //Posts
            }
            return nRow;
        }
    });

});
function refundCharge(chargeId){
    $.ajax({
        type: "POST",
        url: '/club/refund',
        data: {refund: chargeId},
        error: function(e){
            //logIt(err.message);
            $("#show_charge").empty();
            $("#show_charge").append('<div>'+ e["responseText"] +'</div><hr class="shadow">').css('color','red');
        },
        success: function(data){
            showPaymentInfo(data,chargeId);
        },
        dataType: "JSON",
        async: false
    })
}

function getCharge(chargeId){

    $.ajax({
        type: "POST",
        url: '/club/charge',
        data: {charge:chargeId},
        error: function(e){
            //$("#loading").remove();
            $("#show_charge").empty();
            $("#show_charge").append('<div>'+e["responseText"]+'</div><hr class="shadow">').css('color','red');
        },
        success: function(data){
           // $("#loading").remove();
            showPaymentInfo(data,chargeId);
        },
        dataType: "JSON",
        async: false
    })
}

function showPaymentInfo(data,chargeId){
    $("#show_charge").empty();
    $("#show_charge").dialog('option','title','payment details | '+ data.description);
    $('#show_charge').append(
        '<table class="table-condensed table-striped">' +
            '<thead><th>Card Type</th><th>last 4</th><th>exp date</th><th>paid</th><th>stripe fee</th><th>date paid</th><th>refund amt</th>' +
            '</thead>' +
            '<tbody><tr>' +
            '<td>'+data.card.type+'</td><td>'+data.card.last4+'</td>' +
            '<td>'+data.card.exp_month+'/'+data.card.exp_year+'</td>' +
            '<td>$'+(data.amount/100).toFixed(2)+'</td>' +
            '<td>$'+(data.fee/100).toFixed(2)+'</td>' +
            '<td>'+convertTimeStamp(data.created)+'</td>'+
            '<td id="refund_amt">$'+(data.amount_refunded/100).toFixed(2)+'</td>' +
            '</tr>' +
            '</table>'
    ).fadeIn("slow");
    $("#show_charge").append('<hr class="shadow">');
    $("#show_charge").append('<br><h6 id="payId">--Payment ID: '+chargeId+'</h6>');
    $("#show_charge").append('<br><h6>--Email: ' + data.description + '</h6>');
    if(data.amount_refunded != 0){
        $(":button:contains('Refund')").prop("disabled", true).addClass("ui-state-disabled");
        $("#refund_amt").css('color','red');
    }else{
        $(":button:contains('Refund')").prop("disabled", false).removeClass("ui-state-disabled");
    }
}
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
        if (validator.numberOfInvalids() == "0"){  //check for validation errors before submitting
            form$.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
            form$.get(0).submit();
        }
         else{
            $('#tabs').tabs('select',0); //if there is invalid data return to the main tab
        };


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
                email: true,
                remote: '/user/validation'
            },
            "user[password]": {
                required: true,
                minlength: 6
            },
            "user[password_confirmation]": {
                equalTo: "#user_password"
            },
            "txt_referred_by":{
                email: true
            }
        }, //end of rules
        messages:{
            "user[name]": {
                required: "you need to enter a name!",
                minlength: "your name has to be at least 2 characters"
            },
            "user[email]": {
                required: "you must enter your email address!",
                email: "this must be a valid address, example: me@here.com",
                remote: 'this email address is already being used by another account...'
            },
            "user[password]": {
                minlength: "your password must be at least 6 charaters"
            },
            "user[password_confirmation]": {
                equalTo: "not matching..."
            }
        }, //end of messages
        success: function(label){
            label.addClass('valid');
        }//end of success
    }); //end validate new_user
    return validator;
}