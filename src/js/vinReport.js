let carContract = web3.eth.contract(config.carContractABI).at(config.carContractAddress);

// carContract.getCarByVin(vin, function(err, isExist){
// 	if(!err){
// 		console.log(isExist);
// 	}
// });

carContract.getRepairsCount(vin,function(err, repairsCount){
	if(!err) {
		$('.repairsList').text('');
		
		for(let i = 0; i < repairsCount.toNumber();i++){
			carContract.getRepair(vin, i, function(err, data){
				let serviceAddress = data[0];
				let reason = data[1];
				var timestamp = new Date(data[2] * 1000).toISOString().slice(0,10);
				let html = '<li>' + timestamp + ' - ' + reason + ' - service address ' + serviceAddress + '</li>';
					
				$('.repairsList').append(html);
			});
		}
	} else {
		console.log("Can't get count of repairs");
	}
});