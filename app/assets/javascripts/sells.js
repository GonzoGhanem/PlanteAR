$(document).ready(function() {
  	attach_showprice();
  	attach_select2();
    $('#sells_filter input').change(personalized);
    $('#sells-today').click(onlytoday);
    $('#sells-remove').click(removefilter);
    $('#sells-month').click(onlymonth);
    $('#sells').dataTable({
      "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $('#sells').data('source')
  });
});
  
  var personalized = function(){
      $('h3 span').text("'Filtro personalizado'");
  };
  var onlytoday = function(){
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    if (month < 10)
      month = '0' + month;
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();
    $('input').val(year+'-'+month+'-'+day);
    $('input').keyup(); // Hack to filter after changing value from js. Datatable uses keyup event instead of onchange.
    $('input').val("");
    $('h3 span').text("'Solo hoy'")
  };

  var onlymonth = function(){
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    if (month < 10)
      month = '0' + month;
    var year = currentTime.getFullYear();
    $('input').val(year+'-'+month+'-');
    $('input').keyup(); // Hack to filter after changing value from js. Datatable uses keyup event instead of onchange.
    $('input').val("");
    $('h3 span').text("'Solo este mes'")
  };

  var removefilter = function(){
    $('input').val("");
    $('input').keyup();
    $('h3 span').text("'Todas'")
  };

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