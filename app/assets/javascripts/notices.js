$(document).ready(function(){
    $('#new_notice').dialog({
        autoOpen: false,
        title: "new club notice",
        height: 615,
        width: 600,
        open: {effect: "fadeIn", duration: 500},
        hide: {effect: "fadeOut", duration: 500},
        modal: true
    });
    $('#btnNewSession').click(function event(){
       $('#new_notice').dialog('open');
        return false;
    });
});