//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require bootstrap
//= require_tree .
$(document).ready(function() {
  	attach_recalc();
	$('.dropdown-toggle').dropdown()
});
  
  var applyTotalDiscount = function(){
    var discount = $(this).val();
    $('#total_amount').val(0);
    $('input[id$="subtotal"]').each(function(i,o){
      if($.isNumeric($(o).val()))
        $('#total_amount').val(parseFloat($('#total_amount').val(),2) + parseFloat($(o).val()) );
      });
    if (! $.isNumeric(discount) || discount > 100 || discount < 0)
      { 
        alert("El descuento total ingresado debe ser un numero, menor que 100% y mayor a 0%");
        $(this).val(0);
        $(this).focus();
        return;
      }
    else
      {
        var new_total = $('#total_amount').val() * ((100 - discount) / 100);
        $('#total_amount').val(new_total.toFixed(2));
      };
  };

  var recalc = function(){
    var quantity = $( '#' + $(this).attr('id').replace('unit_price', 'amount').replace('discount', 'amount') ).val(); 
    var price =  $( '#' + $(this).attr('id').replace('amount', 'unit_price').replace('discount', 'unit_price') ).val();

    var discount =  $( '#' + $(this).attr('id').replace('amount', 'discount').replace('unit_price', 'discount') ).val();

    var $subtotal = $( '#' + $(this).attr('id').replace('amount', 'subtotal').replace('unit_price', 'subtotal').replace('discount', 'subtotal') );
    
    if( ! $.isNumeric(quantity) || !$.isNumeric(price) )
        return;
    
    if (! $.isNumeric(discount))
      $subtotal.val((quantity * price).toFixed(2));  
    else 
      $subtotal.val((quantity * price * ((100 - discount) / 100)).toFixed(2));
    $('#total_amount').val(0);
    $('input[id$="subtotal"]').each(function(i,o){
      if($.isNumeric($(o).val()))
        $('#total_amount').val(parseFloat($('#total_amount').val(),2) + parseFloat($(o).val()) );
    });

    if ($.isNumeric($("#total_discount").val()))
    {
      var new_total = $('#total_amount').val() * ((100 - discount) / 100);
      $('#total_amount').val(new_total.toFixed(2));
    };
  };

  var attach_recalc = function(){
    $('input[id$="amount"], input[id$="unit_price"], input[id$="discount"]').keypress(recalc);
    $('input[id$="amount"], input[id$="unit_price"], input[id$="discount"]').change(recalc);
    $("#total_discount").change(applyTotalDiscount);
    // $("#total_discount").keypress(applyTotalDiscount);
  };

$(function() {
    return $('form').on('click', '.remove_fields', function(event) {
      $(this).prev('input[type=hidden]').val('1');
      var test = $(this).prev('input[type=hidden]')
      if ($.isNumeric($(test).prev('input[type=text]').val()))
        $("#total_amount").val($("#total_amount").val() - $(test).prev('input[type=text]').val());
      $(this).closest('tr').hide();
      return event.preventDefault();
    });
  });

$(function() {
  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    new_section = $(this).data('fields').replace(regexp, time);
    $("table tr:last").after(new_section);
    attach_recalc();
    attach_select2();
    attach_functions();
    return event.preventDefault();
  });
});