/**
 * Created with JetBrains RubyMine.
 * User: USER1
 * Date: 9/22/12
 * Time: 2:38 PM
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function(){
    $('#frmLogin').hide();

    $('#btnLogin').click(function(event){
        $('#frmLogin').dialog('open');
        return false;
    });

    $('#frmLogin').dialog({
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        height: 350,
        width: 300,
        modal: true
    });
});
