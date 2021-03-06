/**
 * Created with JetBrains RubyMine.
 * User: USER1
 * Date: 8/4/12
 * Time: 9:09 AM
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function(){
    $('#new_event').dialog({
        autoOpen: false,
        open: {effect: "fadeIn", duration: 500},
        hide: {effect: "fadeOut", duration: 500},
        modal: true
    });
    $('#btnNewEvent').click(function event(){
        $('#new_event').dialog('open');
        return false;
    });

    $('#calendar').fullCalendar({
        editable: false,
        theme: true,
        ignoreTimezone: false,
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        weekMode: 'liquid',
        defaultView: 'month',
        height: 500,
        firstHour: 5,
        slotMinutes: 30,

        loading: function(bool){
            if (bool)
                $('#loading').show();
            else
                $('#loading').hide();
        },

        // a future calendar might have many sources.
        eventSources: [{
            url: '/events',
            ignoreTimezone: true
        }],
        timeFormat: 'h:mm t',
        dragOpacity: "0.8",

        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
            // would like a lightbox here.
        }
    });
});
