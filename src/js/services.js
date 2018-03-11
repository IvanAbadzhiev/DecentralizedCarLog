let contractService = web3.eth.contract(config.serviceContractABI).at(config.serviceContractAddress);

	/* Contract events */
	let NewAutoService = contractService.NewAutoService();

	NewAutoService.watch(function(error, result){
		if(!error){
			toastr.success("New service is added");
			getServices();
		}
	})


	$("#serviceImage").on("change", function(){
		const reader = new FileReader();
		ipfsFileReader(reader, "serviceImage");
	});

    function getServices(){
    	contractService.getServicesLength(function(err, result){
    		let serviceLength = result.toNumber();

    		for (var i = 0; i < serviceLength; i++) {
    			contractService.getService(i,function(err,result){
		    		if(!err){
		    			console.log(result);
		    			$("#serviceRow").text(''); //remove previous result
		    			let name = result[0];
		    			let image = result[1];
		    			let address = result[2];

		    			let html = '<div class="col-sm-6 col-md-4 col-lg-3">';
		    			html += '<div class="panel panel-default">';
		    			html += '<div class="panel-heading">';
		    			html += '<h3 class="panel-title">' + name + '</h3>';
		    			html += '</div>'

		    			html += '<div class="panel-body">';
		    			html += '<img class="img-rounded img-center" style="width: 100%;" src="' + image + '">';
		    			html += '<br/><br/>';
		    			html += '<strong>Address</strong>: <span class="address">' + address + '</span><br/>';			    				
			    		html += '</div>';
			    		html += '</div>';
			    		html += '</div>';

			    		$('#serviceRow').append(html);
		    		}
		    	});
    		}
    	});
    }

    function addService(name,image) {
    	contractService.addService(name, image, { from : web3.eth.accounts[0], value : web3.toWei(1,'ether') },
    			function(err, data){
    		//if(!err){ location.reload(); }
    	});
    }

    $("#addService").on("click", function(){
    	$(".error").text('');
    	let service_name = $("#name").val();

    	if(!service_name){
    		$(".error").text('Please write a valid service name');
    		return;
    	} 

    	if(service_name.length < 3){
    		$(".error").text('Service name must be over 3 characters');
    		return;
    	}

    	let image = $("#ipfsImage").val();

    	if(!image){
    		$(".errorImage").text('Please add image of your vehicle');
    	}
    	
    	addService(service_name,image);
    });

    
    
    $(document).ready(function(){
    	getServices();
    });