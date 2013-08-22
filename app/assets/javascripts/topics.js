/**
 * Created with JetBrains RubyMine.
 * User: USER1
 * Date: 9/22/12
 * Time: 8:22 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){
    /* $('#btnNewTopic').click(function(event){
        $('#frmNewTopic').dialog('open');
        return false;
    });

    $("#btnCreateTopic").click(function(event){
        //add the ajax action to add new topic
        addTopic();
        $("#frmNewTopic").dialog('close');
        return false;
    }); */

    $('#frmNewTopic').dialog({
        title: "New Topic",
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        close: {effect: "fadeOut", duration: 500},
        height: 425,
        width: 425,
        modal: true
    });

    //ajax reply//
    $('#topic_reply').click(function(){
        $("#loading").append("testing");
        updateTopic($("#topic_forum_id").val(), $("#reply").val());
        //move the browser focus to the top
        window.scroll(0,0);
        return false;
    });
});

function addTopic(){
    $.ajax({
        type: "POST",
        url: "/topics/addtopic",
        dataType: "JSON",
        data: {forum_id: $("#topic_forum_id").value,
            post:{content: $("#topic_content"), name: $("#topic_name")}
        },
        error:function(e){
            //alert("You have trapped an error with message " + e.statusText)
            $("#jsFlash").css({
                position: "absolute",
                width: "60%"
            }).text(e.StatusText).addClass("alert-error").toggle('slow').delay(5000).toggle('slow');

        },
        success:function(e){
            $("#jsFlash").css({
                position: "absolute",
                width: "60%"
            }).text("sucess").addClass("alert-success").toggle('slow').delay(5000).toggle('slow');

        }
    });
}
function updateTopic(id,content){

    $.ajax({
        type: "POST",
        url: "/topics/ajax",
        dataType: "JSON",
        data: {id: id,
               post:{content: content}
        },
        error:function(e){
            //alert("You have trapped an error with message " + e.statusText)
            $("#jsFlash").css({
                position: "absolute",
                width: "60%"
            }).text(e.StatusText).addClass("alert-error").toggle('slow').delay(5000).toggle('slow');

        },
        success: function(data){
            var editUrl = "/posts/"+data.id+"/edit";
            var editLink = '<a href="'+editUrl+'" class="btn btn-mini btn-primary"  data-method="get"><i class="icon-pencil icon-white"></i></a>';
            var result = '<tr><td width="70%">' +
                '<div style="word-wrap: break-word"><p>'
                + content +'</p></div></td>' +
                '<td width="10%">Posted By: '+data.user.name+'</td>' +
                '<td width="10%">just now</td>' +
                '<td width="10%">'+editLink+'</td>' +
                '</tr>'
            $(result).hide().prependTo("#tblPosts").fadeIn('slow');
            $("#reply").val("");
            $("#jsFlash").css({
                position: "absolute",
                width: "60%"
            }).text("Post added!").addClass("alert-success").toggle('slow').delay(5000).toggle('slow');
        }
    })
}