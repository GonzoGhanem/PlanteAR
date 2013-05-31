$(document).ready(function() {
    attach_functions();
});
  

  var onlytoday = function(){
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    if (month < 10)
      month = '0' + month;
    var day = currentTime.getDate();
    var year = currentTime.getFullYear();
    var filter = year+'-'+month+'-'+day;
    doFilter(filter);
    $('h3 span').text("'Solo hoy'")
  };

  var onlymonth = function(){
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    if (month < 10)
      month = '0' + month;
    var year = currentTime.getFullYear();
    var filter = year+'-'+month+'-';
    doFilter(filter);
    $('h3 span').text("'Solo este mes'")
  };

  var removefilter = function(){
    var filter = "";
    doFilter(filter);
    $('h3 span').text("'Todas'")
  };

  var doFilter = function(filter_value){
    $('input').val(filter_value);
    $('input').keyup(); // Hack to filter after changing value from js. Datatable uses keyup event instead of onchange.
    $('input').val("");
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

  
  var attach_functions = function(){
    // Attach the filter function to the filter links
    // $("input").change(personalized);
    $('#sells-today').click(onlytoday);
    $('#sells-remove').click(removefilter);
    $('#sells-month').click(onlymonth);
    ///////////////////////////////////
    $('select[id$="product_id"]').change(showprice);
    ///////////////////////////////////
    $('select[id$="product_id"]').select2({
      placeholder: "Seleccione un producto",
      allowClear: true
    });
    ///////////////////////////////////
    $('#sells').dataTable({
      "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $('#sells').data('source')
    });
  };
