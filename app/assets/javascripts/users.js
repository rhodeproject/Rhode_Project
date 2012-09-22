$(document).ready(function(){
    $('#btnNewUser').click(function(event){
        Stripe.createToken({
                number: $('#card_number').val(),
                cvc: $('#card_code').val(),
                exp_month: $('#card_month').val(),
                exp_year: $('#card_year').val()
            }, stripeResponseHandler);
        return false;
    });

    $('#tblUsers').dataTable({
        "bRetrieve": true,
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": false,
        "bInfo": true,
        "bAutoWidth": false,
        "bJQueryUI": true
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