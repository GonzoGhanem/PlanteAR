$(document).ready(function() {
    attach_functions();
});
  

  var onlytoday = function(){
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    if (month < 10)
      month = '0' + month;
    var day = currentTime.getDate();
    if (day < 10)
      day = '0' + day;    
    var year = currentTime.getFullYear();
    var filter = year+'-'+month+'-'+day;
    doFilter(filter);
    $('h3 small').text("Solo hoy" + day+'/'+month+'/'+year);
  };

  var onlyyesterday = function(){
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    if (month < 10)
      month = '0' + month;
    var day = currentTime.getDate() - 1;
    if (day < 10)
      day = '0' + day;    
    var year = currentTime.getFullYear();
    var filter = year+'-'+month+'-'+day;
    doFilter(filter);
    $('h3 small').text("Solo ayer - " +  day+'/'+month+'/'+year);
  };

  var onlymonth = function(){
    var currentTime = new Date();
    var month = currentTime.getMonth() + 1;
    if (month < 10)
      month = '0' + month;
    var year = currentTime.getFullYear();
    var filter = year+'-'+month+'-';
    doFilter(filter);
    $('h3 small').text("Solo " + getMonthName(month));
  };

  var removefilter = function(){
    var filter = "";
    doFilter(filter);
    $('h3 small').text("Todas");
  };

  var doFilter = function(filter_value){
    $('input').val(filter_value);
    $('input').keyup(); // Hack to filter after changing value from js. Datatable uses keyup event instead of onchange.
    $('input').val("");
  };

  var showprice = function(){
    var product_id = $(this).val(); 
    var amount_field =  $( '#' + $(this).attr('id').replace('product_id', 'amount'));
    var price_field =  $( '#' + $(this).attr('id').replace('product_id', 'unit_price'));
    var subtotal_field = $( '#' + $(this).attr('id').replace('product_id', 'subtotal'));
    $(amount_field).val(1);
    if (product_id === ""){
      $(price_field).val(0);
      $(amount_field).val(0);
      if ($.isNumeric($(subtotal_field).val())){
        $('#total_amount').val(parseFloat($('#total_amount').val(),2) - parseFloat($(subtotal_field).val()) );
      };
      $(subtotal_field).val(0);
      return;
    };
    $.get('/products/'+ product_id +'.json', function(data){
    	var price = data.sell_price;
    	if (price == null){
    		$(price_field).val(0);
        return;
      }
    	else{  
        $(price_field).val(price);
        $(subtotal_field).val($(price_field).val() * $(amount_field).val());
        $('#total_amount').val(0);
        $('input[id$="subtotal"]').each(function(i,o){
          if($.isNumeric($(o).val()))
            $('#total_amount').val(parseFloat($('#total_amount').val(),2) + parseFloat($(o).val()) );
        });
      };
    });    
  };
  
  var getMonthName = function(month){
    var months = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
    if (month[0] == "0"){
      return months[parseInt(month[1]) - 1];
    }
    else{
      return months[parseInt(month) - 1];
    };
  };
  var attach_functions = function(){
    // Attach the filter function to the filter links
    // $("input").change(personalized);
    $('#sells-today').click(onlytoday);
    $('#sells-yesterday').click(onlyyesterday);    
    $('#sells-remove').click(removefilter);
    $('#sells-month').click(onlymonth);
    ///////////////////////////////////
    $('select[id$="product_id"]').change(showprice);
    ///////////////////////////////////
    attach_select2();
    ///////////////////////////////////
    $('#sells').dataTable({
      "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
      "sPaginationType": "bootstrap",
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $('#sells').data('source')
    });
    $(".btn-danger").focus();
  };

  var attach_select2 = function(){
    $('select[id$="product_id"]').select2({
      placeholder: "Seleccione un producto",
      allowClear: true
    });
  };
