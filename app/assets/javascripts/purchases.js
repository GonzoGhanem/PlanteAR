$(document).ready(function () {
  attach_recalc();
  $('.product-field').each(function(i,o){
      var isDisabled = $('.product-field')[i].value.length > 0; 
      $('.product-field')[i].disabled = isDisabled;
  });
  // disableField();
});



$(function() {
    return $('form').on('click', '.remove_fields', function(event) {
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('tr').hide();
      return event.preventDefault();
    });
  });

  // var disableField = function(){
  //     $('.product-field').each(function(i,o){
  //     var isDisabled = $('.product-field')[i].value.length > 0; 
  //     $('.product-field')[i].disabled = isDisabled;
  // });
  // };

  var recalc = function(){
    var quantity = $( '#' + $(this).attr('id').replace('unit_price', 'amount') ).val(); 
    var price =  $( '#' + $(this).attr('id').replace('amount', 'unit_price') ).val();

    var $subtotal = $( '#' + $(this).attr('id').replace('amount', 'subtotal').replace('unit_price', 'subtotal') );
    
    if( ! $.isNumeric(quantity) || !$.isNumeric(price) )
        return;

    $subtotal.val( quantity * price );

    $('#purchase_amount').val(0);
    $('input[id$="subtotal"]').each(function(i,o){
      if($.isNumeric($(o).val()))
        $('#purchase_amount').val(parseFloat($('#purchase_amount').val(),2) + parseFloat($(o).val()) );
    });
  };

  var attach_recalc = function(){
    $('input[id$="amount"], input[id$="unit_price"]').keypress(recalc);
    $('input[id$="amount"], input[id$="unit_price"]').change(recalc);
  };

$(function() {
  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    new_section = $(this).data('fields').replace(regexp, time);
    $("table tr:last").after(new_section);
    attach_recalc();
    return event.preventDefault();
  });
});
