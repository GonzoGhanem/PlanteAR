$(document).ready(function() {
  	attach_showprice();
  	attach_select2();
});
  

  var showprice = function(){
    var product_id = $(this).val(); 
    var price_field =  $( '#' + $(this).attr('id').replace('product_id', 'unit_price'));
    if (product_id === ""){
      $(price_field).val(0);
      return;
    };
    $.get('/products/'+ product_id +'.json', function(data){
    	var price = data.sell_price;
    	if (price == null)
    		$(price_field).val(0);
    	else	
    		$(price_field).val(price);		
    });    
  };

  var attach_showprice = function(){
    $('select[id$="product_id"]').change(showprice);
  };

  var attach_select2 = function(){
    $('select[id$="product_id"]').select2({
      placeholder: "Seleccione un producto",
      allowClear: true
  });
};