
pragma solidity ^0.4.18;

contract CarLog  {
    
    struct Car {
        string vin;
        string image;
        bool isExist;
        address owner;
        address service;
    }
    
    struct Repair {
     address service;
     string repair;
     uint256 timestamp;
    }
    
    address contractOwner;
    CarService serviceContract;
   mapping (address => Car[]) owners;
   mapping (string => Car) carToVins;
   mapping (string => Repair[]) carToRepairs;
   
   event vehicleAdded(address indexed vehicleOwner, string vin);
   event newCarRepair(string indexed vin);
   
   modifier isVinExist(string vin){
       require(carToVins[vin].isExist == false);
       _;
   }
   
   modifier onlyCarOwner(string vin){
       require(carToVins[vin].owner == msg.sender);
       _;
   }
   
   modifier onlyCarService(string vin){
       require(msg.sender == carToVins[vin].service);
       _;
   }
   
   modifier isService(address _address){
       require(serviceContract.getServiceByAddress(_address) == true);
       _;
   }
   
   modifier onlyOwner(){
       require(msg.sender == contractOwner);
       _;
   }
   
   function CarLog(address _serviceContractAddress) public {
       contractOwner = msg.sender;
       serviceContract = CarService(_serviceContractAddress);
   }
   
   function addCar(string _vin, string image) public isVinExist(_vin) {
       owners[msg.sender].push(Car(_vin, image, true, msg.sender, 0x0));
       carToVins[_vin] = Car(_vin, image, true, msg.sender, 0x0);
       emit vehicleAdded(msg.sender, _vin);
   }
   
   function getMyCarsCount() public view returns(uint) {
       return owners[msg.sender].length;
   }
   
   function getMyCar(uint index) public view returns(string, string, address){
       Car memory myCar = owners[msg.sender][index];
       return (myCar.vin, myCar.image, myCar.service);
   }
   
   function getCarByVin(string _vin) public view returns(string){
       return carToVins[_vin].image;
   }

   function addServiceToCar(string _vin, address serviceAddress) public onlyCarOwner(_vin){
       carToVins[_vin].service = serviceAddress;
   }
   
   function addRepair(string _vin, string _repair) public onlyCarService(_vin) isService(msg.sender){
       Repair memory newRepair;
       newRepair.service = msg.sender;
       newRepair.repair = _repair;
       newRepair.timestamp = block.timestamp;
       
       carToRepairs[_vin].push(newRepair);
       emit newCarRepair(_vin);
   }
   
   function getRepairsCount(string _vin) public view returns(uint256){
       return carToRepairs[_vin].length;
   }
   
   function getRepair(string _vin,uint256 index) public view returns(address,string,uint256){
       Repair memory repair = carToRepairs[_vin][index];
       return (repair.service, repair.repair, repair.timestamp);
   }
   
   function () payable public { }
   
   //kill and return funds to service owners
   function kill() public onlyOwner {
       selfdestruct(msg.sender);
   }
}