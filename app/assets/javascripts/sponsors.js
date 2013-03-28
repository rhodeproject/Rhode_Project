$(document).ready(function(){
   $('#new_sponsor').dialog({
       title: "add new sponsor",
       autoOpen: false,
       open: {effect: "fadeIn", duration: 500},
       height: 650,
       width: 450,
       modal: true
   });

    $('#btnNewSponsor').click(function(event){
       $('#new_sponsor').dialog('open');
    });
});