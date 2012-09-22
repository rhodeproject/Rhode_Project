$(document).ready(function(){
    $('#new_notice').dialog({
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        hide: {effect: "fadeOut", duration: 500},
        modal: true
    });
    $('#btnNewSession').click(function event(){
       $('#new_notice').dialog('open');
        return false;
    });
});