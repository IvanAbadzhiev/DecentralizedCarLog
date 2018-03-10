$(".oncopy").bind({
	copy : function(e){
		$("#vehicleVin").val('1HGCG1653YA038847');	
	}
});

$("#checkVin").on("click", function(){
	let vin = $("#vehicleVin").val();

	if(!vin){
  		$(".error").text('Please write valid car vin');
    	return;
    } 

   	if(vin.length !== 17){
   		$(".error").text('Service name must be 17 characters');
   		return;
   	}

   	location = '/vin/' + vin;
});