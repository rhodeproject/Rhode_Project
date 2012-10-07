/**
 * Created with JetBrains RubyMine.
 * User: USER1
 * Date: 9/22/12
 * Time: 8:22 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){
    $('#btnNewTopic').click(function(event){
        $('#frmNewTopic').dialog('open');
        return false;
    });

    $('#frmNewTopic').dialog({
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        height: 300,
        width: 600,
        modal: true
    });


});
