$(function() {
    return $('form').on('click', '.remove_fields', function(event) {
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('tr').hide();
      return event.preventDefault();
    });
  });

// $(function() {
//   $('price-field').change(function(){
//     $('#purchase_line_items_attributes_0_subtotal').val($('#purchase_line_items_attributes_0_unit_price').val() * $('#purchase_line_items_attributes_0_amount').val());
//   });
// });


$(function() {
  $('#purchase_line_items_attributes_0_unit_price').change(function(){
    $('#purchase_line_items_attributes_0_subtotal').val($('#purchase_line_items_attributes_0_unit_price').val() * $('#purchase_line_items_attributes_0_amount').val());
  });
});
  // var amount = document.getElementById('purchase_line_items_attributes_0_amount');
  // var price = document.getElementById('purchase_line_items_attributes_0_unit_price');
  // var subtotal = document.getElementById('purchase_line_items_attributes_0_subtotal');

  // subtotal.setAttribute('onBlur', 
  //   function () {
  //     var sub = parseFloat(amount.value) * parseFloat(price.value);
  //     subtotal.value = sub;
  //   });
  // });

// $(function() {
//   var regexp, time;

//   $('form').on('click', '.add_fields', function(event) {});

//   time = new Date().getTime();

//   regexp = new RegExp($(this).data('id'), 'g');

//   $(this).before($(this).data('fields').replace(regexp, time));
//   event.preventDefault();

// });
