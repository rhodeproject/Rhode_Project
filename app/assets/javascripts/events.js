/**
 * Created with JetBrains RubyMine.
 * User: USER1
 * Date: 8/5/12
 * Time: 9:14 AM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){
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