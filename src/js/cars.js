let carContract = web3.eth.contract(config.carContractABI).at(config.carContractAddress);

	/* Event handling */
	eventVehicleAdded = carContract.vehicleAdded({});
    eventNewCarRepair = carContract.newCarRepair();

    eventVehicleAdded.watch(function(error, result){
    	if(!error){
    		toastr.success("Your vehicle is successfully added");
    		eventVehicleAdded.stopWatching()
    		getCars();
    	} else {
    		console.log(error);
    		toastr.error("Something went wrong. Look in the console for more information");
    	}
    });

    eventNewCarRepair.watch(function(error, result){
    	console.log("* eventNewCarRepair " + result);
    	if(!error){
    		toastr.success("You successfully add a service to your car");
    		eventNewCarRepair.stopWatching();
    	} else {
    		console.log(error);
    		toastr.error("Something went wrong. Look in the console for more information");
    	}
    })

	function addACar(vin, image){
		$('.success').val('');

		carContract.addCar(vin, image, function(error, result) {
			if(!error) { 
				$('.success').append("Success: Your vehicle will be in the chain soon, you can check your transaction <a target=\"blank\" href='https://ropsten.etherscan.io/tx/" + result + "'>here</a>");
			} else {
				console.log(error);
    			toastr.error("Something went wrong. Look in the console for more information");
			}
		});
	}

	function getCars(){
		$('#carRow').text('');

		carContract.getMyCarsCount(function(error, data){
			if(!error) {
				let carsCount = data.toNumber();
				
				for (let i = 0; i < carsCount; i++) {
				
					carContract.getMyCar(i, function(error, result){
						let vin = result[0];
						let image = result[1];
						let serviceAddress = result[2];

						let html = '<div class="col-sm-6 col-md-4 col-lg-3">';
	    				html += '<div class="panel panel-default">';
	    				html += '<div class="panel-heading">';
	    				html += '<h3 class="panel-title">' + vin + '</h3>';
	    				html += '</div>'

	    				html += '<div class="panel-body">';
	    				html += '<img style="width: 100%;" src="' + image + '">';
	    				html += '<br/><br/>';
	    				html += '<strong>Add service</strong>: <br/>';
	    				html += '<strong>Address</strong>: <input type="text" class="form-control" value="' + serviceAddress + '"><br/>';
	    				html += '<button class="btn btn-default addService serviceAddress" type="button" data-vin="' + vin + '">Add a car service</button><br/>';
	    				html += '<span class="errorAddress"></span>';
	    				html += '</div>';
	    				html += '</div>';
	    				html += '</div>';

	    				$('#carRow').append(html);
					});
				}
			} else {
				console.log(error);
    			toastr.error("Something went wrong. Look in the console for more information");
			}
		});
	}

	$("#carImage").on("change", function(){
		const reader = new FileReader();
      	ipfsFileReader(reader, "carImage");
	});

	$("#addAcar").on("click", function(){
		$(".error").text('');

		let vin = $("#vin").val();

		if(!vin){
    		$(".error").text('Please write a valid vehicle vin');
    		return;
    	} 

    	if(vin.length !== 17){
    		$(".error").text('The vehicle vin must be 17 characters');
    		return;
    	}

    	let image = $("#ipfsImage").val();

    	if(!image){
    		$(".errorImage").text('Please add image of your vehicle');
    	}

    	addACar(vin,image);
	});

	$('body').on('click', 'button.addService', function() {
		let $errorSpan = $(this).next().next();
    	let vin = $(this).data("vin");
    	let address = $(this).prev().prev().val();
    	
    	$errorSpan.text('');

    	if(!address){
    		$errorSpan.text('Please write a valid address');
    		return;
    	}

    	carContract.addServiceToCar(vin, address, function(err, data){
    		if(!err){
    			console.log(data);
    		}
    	})
	});

	$(document).ready(function() {
		getCars();
	});