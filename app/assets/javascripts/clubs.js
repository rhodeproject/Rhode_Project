/**
 * Created with JetBrains RubyMine.
 * User: USER1
 * Date: 7/31/12
 * Time: 9:04 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){
    $("#club_name").popover({
        animation: true,
        placement: "right",
        title: "New Club Name",
        content: "Enter the name of your club",
        delay: { show: 500, hide: 100 }
    });
    $("#club_sub_domain").popover({
        animation: true,
        placement: "right",
        title: "Sub Domain",
        content: "The sub-domain will be a unique name that will represent your club in the URL your members will use to access your site. For example, <em>clubname</em>.rhodeproject.com, where <em>clubname</em> is the Custom URL",
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
        content: "Enter the password. Do not use any common words, this is your admin user password!",
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

});
