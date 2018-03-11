if(!window.getCookie("signedAuthMessage")){
	web3.eth.sign(web3.eth.coinbase, web3.sha3("CarDapp"), function(err, data){
		console.log(err);
		if(!err){
			let signedAuthMessage = data;
			document.cookie = "signedAuthMessage=" + signedAuthMessage;
		} else {
			console.log(err);
			toastr.error('Something is broken, you can find more information in the console', 'Network error!')
		}
	});
}

let contractService = web3.eth.contract(config.serviceContractABI).at(config.serviceContractAddress);
let carContract = web3.eth.contract(config.carContractABI).at(config.carContractAddress);

$("#AddRepairButton").on("click", function(){
	let vinCode = $("#vinCode").val();
	let repairText = $("#repairText").val();

	carContract.addRepair(vinCode, repairText, function(err, result){
		if(err){
			toastr.error("Somethings wrong");
			console.log(err);
		}
	})
});

$(document).ready(function(){
	contractService.isService(function(error, isExist){
		if(!error) {
			if(!isExist){
				$('.jumbotron').html('You are not a Car Service. ');
			}
		} else {
			toastr.error("Somethings wrong");
		console.log(error);
		}
	});
});