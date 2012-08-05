// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require_tree .


$(document).ready(function() {
    $("#edit_topic").submit(function(){
        $('#commit').attr("disabled", "disabled");
        $.post($(this).attr("action") + '.js', $(this).serialize(), null, "script");
        $('#commit').removeAttr("disabled");
        $('#post[commit]').attr("value","");
        return false;
    });
});

$(document).ready(function () {

    $('.ccinput').keyup(function() {
        if($(this).val() == 4){
            $('#ccbox').css('background-position', '0 -23px');
        }
        else if($(this).val() == 5){
            $('#ccbox').css('background-position', '0 -46px');
        }
        else if($(this).val() == 3){
            $('#ccbox').css('background-position', '0 -69px');
        }
        else if($(this).val() == 6){
            $('#ccbox').css('background-position', '0 -92px');
        }
        else if($(this).val() == ''){
            $('#ccbox').css('background-position', '0 0');
        }
    });
});
$(document).ready(function() {

    jQuery.ajaxSetup({
        'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
    });

    //Date Picker for new events
    $('#event_starts_at').datetimepicker({
        onClose: function(dateText, inst){
            var endDateTextBox = $('#event_ends_at');
            if (endDateTextBox.val() != '') {
                var testStartDate = new Date(dateText);
                var testEndDate = new Date(endDateTextBox.val());
                if (testStartDate > testEndDate)
                    endDateTextBox.val(dateText);
            }
            else {
                endDateTextBox.val(dateText);
            }
        },
        onSelect: function (selectedDateTime){
            var start = $(this).datetimepicker('getDate');
            $('#event_ends_at').datetimepicker('option', 'minDate', new Date(start.getTime()));
        },
        ampm: true,
        timeFormat: 'hh:mm:ss TT',
        dateFormat: 'yy-mm-dd',
        stepMinute: 15
        });
    $('#event_ends_at').datetimepicker({
        onClose: function(dateTime, inst) {
            var startDateTextBox = $('#event_starts_at');
            if (startDateTextBox.val() != '') {
                var testStartDate = new Date(startDateTextBox.val());
                var testEndDate = new Date(dateText);
                if (testStartDate > testEndDate)
                    startDateTextBox.val(dateText);
            }
            else {
                startDateTextBox.val(dateText);
            }
        },
        ampm: true,
        dateFormat: 'yy-mm-dd',
        timeFormat: 'hh:mm:ss TT',
        stepMinute: 15
    });

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
});

function updateEvent(the_event) {
    $.update(
        "/events/" + the_event.id,
        { event: { title: the_event.title,
            starts_at: "" + the_event.starts_at,
            ends_at: "" + the_event.ends_at,
            description: the_event.description
        }
    },
        function (response) { alert('successfully updated task.'); }
    );
}

