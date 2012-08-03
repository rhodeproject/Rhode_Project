$(document).ready(function(){
    $('#tblUsers').dataTable({
        "bRetrieve": true,
        "bPaginate": true,
        "bLengthChange": false,
        "bFilter": false,
        "bInfo": true,
        "bAutoWidth": false,
        "bJQueryUI": true
    });
});