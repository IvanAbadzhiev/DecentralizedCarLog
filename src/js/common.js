	$(document).ready(function(){
		if (typeof web3 !== 'undefined') {
			web3 = new Web3(web3.currentProvider);
		} else {
			toastr.warning('Please install metamask', 'Metamask!');
		}

		if(web3.version.network != 3 && web3.version.network != null){
			toastr.warning('Please use ropsten network to test my dapp');
		}

		if(web3.eth.coinbase == null){
			toastr.warning('Please sign in metamask');
		}
	});

	window.getCookie = function(name) {
		match = document.cookie.match(new RegExp(name + '=([^;]+)'));
		if (match) return match[1];
	}

	window.sleep = function(miliseconds) {
		var currentTime = new Date().getTime();
		while (currentTime + miliseconds >= new Date().getTime()) {}
	}

const ipfs = window.IpfsApi('ipfs.infura.io', '5001', { protocol: 'https'});
	//const ipfs = window.IpfsApi('localhost', '5001', { protocol : 'http' });

function ipfsFileReader(fileReader,fieldId){
	fileReader.onloadend = function() {
		const buf = buffer.Buffer(fileReader.result) // Convert data into buffer

		let upload = {
			"path" : "attributes.json",
			"content" : buf
		}

		$(".loading").show();

	    ipfs.files.add([upload], (err, result) => { // Upload buffer to IPFS
	       	if(err) {
	       		console.error(err)
	       		return;
	       	}

	      	let url = `https://ipfs.io/ipfs/${result[0].hash}`

	      	$("#ipfsImage").val(url);
	       	$(".loading").hide();
	    });
	}

	const carImage = document.getElementById(fieldId);
	fileReader.readAsArrayBuffer(carImage.files[0]); // Read Provided File
}