let config = {
	"carContractAddress" : "0x8fb909405db525308ae9e4e7970eafd55a5ff8df",
	"carContractABI" : [{"constant":!0,"inputs":[{"name":"_vin","type":"string"}],"name":"getCarByVin","outputs":[{"name":"","type":"string"}],"payable":!1,"stateMutability":"view","type":"function"},{"constant":!0,"inputs":[{"name":"_vin","type":"string"}],"name":"getRepairsCount","outputs":[{"name":"","type":"uint256"}],"payable":!1,"stateMutability":"view","type":"function"},{"constant":!0,"inputs":[{"name":"_vin","type":"string"},{"name":"index","type":"uint256"}],"name":"getRepair","outputs":[{"name":"","type":"address"},{"name":"","type":"string"},{"name":"","type":"uint256"}],"payable":!1,"stateMutability":"view","type":"function"},{"constant":!0,"inputs":[{"name":"index","type":"uint256"}],"name":"getMyCar","outputs":[{"name":"","type":"string"},{"name":"","type":"string"},{"name":"","type":"address"}],"payable":!1,"stateMutability":"view","type":"function"},{"constant":!0,"inputs":[],"name":"getMyCarsCount","outputs":[{"name":"","type":"uint256"}],"payable":!1,"stateMutability":"view","type":"function"},{"inputs":[{"name":"_serviceContractAddress","type":"address"}],"payable":!1,"stateMutability":"nonpayable","type":"constructor"},{"constant":!1,"inputs":[{"name":"_vin","type":"string"},{"name":"image","type":"string"}],"name":"addCar","outputs":[],"payable":!1,"stateMutability":"nonpayable","type":"function"},{"anonymous":!1,"inputs":[{"indexed":!0,"name":"vehicleOwner","type":"address"},{"indexed":!1,"name":"vin","type":"string"}],"name":"vehicleAdded","type":"event"},{"constant":!1,"inputs":[{"name":"_vin","type":"string"},{"name":"_repair","type":"string"}],"name":"addRepair","outputs":[],"payable":!1,"stateMutability":"nonpayable","type":"function"},{"constant":!1,"inputs":[{"name":"_vin","type":"string"},{"name":"serviceAddress","type":"address"}],"name":"addServiceToCar","outputs":[],"payable":!1,"stateMutability":"nonpayable","type":"function"},{"constant":!1,"inputs":[],"name":"kill","outputs":[],"payable":!1,"stateMutability":"nonpayable","type":"function"},{"payable":!0,"stateMutability":"payable","type":"fallback"},{"anonymous":!1,"inputs":[{"indexed":!0,"name":"vin","type":"string"},{"indexed":!1,"name":"serviceAddress","type":"address"}],"name":"newCarRepair","type":"event"}],
	

	"serviceContractAddress" : "0xfdd76e9b64f53209b2a33d9e1428a43a1f1202ab",
	"serviceContractABI" : [{"constant":!0,"inputs":[],"name":"getServicesLength","outputs":[{"name":"","type":"uint256"}],"payable":!1,"stateMutability":"view","type":"function"},{"constant":!0,"inputs":[{"name":"_address","type":"address"}],"name":"getServiceByAddress","outputs":[{"name":"","type":"bool"}],"payable":!1,"stateMutability":"view","type":"function"},{"constant":!0,"inputs":[{"name":"index","type":"uint256"}],"name":"getService","outputs":[{"name":"","type":"string"},{"name":"","type":"string"},{"name":"","type":"address"}],"payable":!1,"stateMutability":"view","type":"function"},{"anonymous":!1,"inputs":[{"indexed":!1,"name":"name","type":"string"}],"name":"NewAutoService","type":"event"},{"constant":!1,"inputs":[{"name":"name","type":"string"},{"name":"image","type":"string"}],"name":"addService","outputs":[],"payable":!0,"stateMutability":"payable","type":"function"},{"constant":!1,"inputs":[],"name":"kill","outputs":[],"payable":!1,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":!0,"stateMutability":"payable","type":"constructor"},{"payable":!0,"stateMutability":"payable","type":"fallback"}]
}