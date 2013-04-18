$(document).ready(function() {
  $('.tooltipField').tooltip();
  $('#products').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
  	"sPaginationType": "bootstrap"
    //bProcessing: true,
    //bServerSide: true,
    //sAjaxSource: $('#products').data('source')
  });

});