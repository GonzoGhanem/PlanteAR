$(document).ready(function() {
  $('#clients').dataTable({
    "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
  	"sPaginationType": "bootstrap",
    bProcessing: true,
    bServerSide: true,
    sAjaxSource: $('#clients').data('source')
  });
  $.extend( $.fn.dataTableExt.oStdClasses, {
    "sWrapper": "dataTables_wrapper form-inline"
});

});