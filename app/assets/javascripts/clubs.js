/**
 * Created with JetBrains RubyMine.
 * User: USER1
 * Date: 7/31/12
 * Time: 9:04 PM
 * To change this template use File | Settings | File Templates.
 */


$(document).ready(function(){

    $("#new_club").validate({
        rules: {
            "club[name]": {
                required: true,
                minlength: 2
            },
            "club[sub_domain]": {
                required: true
            },
            "club[user][name]": {
                required: true,
                minlength: 2
            },
            "club[user][email]": {
                required: true,
                email: true
            },
            "club[user][password]": {
                required: true,
                minlength: 6
            },
            "club[user][password_confirmation]": {
                equalTo: "#club_user_password"
            }
        },
        messages: {
            "club[name]": {
                required: "you must enter a club name",
                minlength: "your club name must be at least 2 charaters long"
            },
            "club[sub_domain]": "you must enter custum url",
            "club[user][email]": {
                required: "you must enter an email address",
                email: "must be a valid email address"
            },
            "club[user][password]": {
                required: "you must enter a pasword",
                minlength: "you password has to be at least 6 characters long"
            },
            "club[user][password_confirmation]": {
                equalTo: "doesn't match"
            }

        },
        success: function(label){
            label.addClass('valid');
            if (label.attr('for') == 'club_sub_domain'){
                label.html("https://" + $('#club_sub_domain').val().toLowerCase() +".rhodeproject.com").addClass('valid_club');
            }
        }
    });

    //Make suggestion on club url name
    //TODO: show what the URL will be
    $("#club_sub_domain").focus(function(){
       var clubName = $("#club_name").val();
        suggestion = cleanURL(clubName);

        if (clubName && !this.value){
            this.value = suggestion;
        }
    });
    $("#club_name").popover({
        animation: true,
        placement: "right",
        title: "New Club Name",
        content: "Enter the name of your club, must be at least 2 charaters.",
        delay: { show: 500, hide: 100 }
    });
    $("#club_sub_domain").popover({
        animation: true,
        placement: "right",
        title: "Sub Domain",
        content: "The sub-domain will be a unique name that will represent your club in the URL your members will use to access your site. For example, <em>https://clubname</em>.rhodeproject.com, where <em>clubname</em> is the Custom URL",
        delay: { show: 500, hide: 100 }
    });
    $("#club_user_name").popover({
        animation: true,
        placement: "left",
        title: "Club Administrative User",
        content: "Enter the name to be used to administer club site",
        delay: { show: 500, hide: 100 }
    });
    $("#club_user_email").popover({
        animation: true,
        placement: "left",
        title: "Administrator Email",
        content: "Enter the email to used by the administrator of club site",
        delay: { show: 500, hide: 100 }
    });
    $("#club_user_password").popover({
        animation: true,
        placement: "left",
        title: "Administrator Password",
        content: "Enter the password. It must be a minimum of 6 characters. Do not use any common words, this is your admin user password!",
        delay: { show: 500, hide: 100 }
    });

    /*Sponsor Cycle*/
    $("#sponsors").cycle({
        fx: 'fade',
        speed: '2500',
        timeout: '1000'
    });

    $(".sponsorLink").click(function(){
       window.open($(this).attr("alt"));
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
                text: "Close",
                click: function(){$(this).dialog("close")}
            },
            {
                text: "Send",
                click: function(event){
                    sendContactAjax($("#contactName").val(),$("#contactEmail").val(),$("#contactMessage").val());
                    $("#contentName").val('');
                    $("#contactEmail").val('');
                    $("#contactMessage").val('');
                    $(this).dialog("close");
                }
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

/*Functions*/
function sendContactAjax(sName,sEmail,sMessage){
    $.ajax({
        type: "POST",
        url: "/contact",
        dataType: "JSON",
        data: {name: sName,
            email: sEmail,
            message: sMessage}
    });
}
function cleanURL(url){
    suggestion = url.replace(/\s+/g, '-');
    suggestion = suggestion.replace(/\'+/g, "");
    suggestion = suggestion.replace(/\"+/g, "");
    suggestion = suggestion.replace(/\@+/g, "-at-");
    suggestion = suggestion.replace(/\/+/g, "");
    suggestion = suggestion.replace(/\\+/g, "");
    suggestion = suggestion.replace(/\&+/g, "and");
    suggestion = suggestion.replace(/\:+/g, "");
    suggestion = suggestion.replace(/\?+/g, "");
    suggestion = suggestion.replace(/\|+/g, "-");
    suggestion = suggestion.replace(/\<+/g, "");
    suggestion = suggestion.replace(/\>+/g, "");
    suggestion = suggestion.replace(/\*+/g, "");
    return suggestion.toLowerCase();
}