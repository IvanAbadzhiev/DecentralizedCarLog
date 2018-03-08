pragma solidity ^0.4.18;

contract CarLog  {
    
    struct Car {
        string vin;
        bool isExist;
    }
    
    struct Repair {
     address service;
     string repair;
     uint256 timestamp;
    }
    
    address contractOwner;
    
   mapping (address => Car[]) cars;
   mapping (string => Car) carToVins;
   mapping (string => Repair[]) carToRepairs;
   
   function CarLog() public{
       contractOwner = msg.sender;
   }
   
   function addCar(string _vin) public {
       cars[msg.sender].push(Car(_vin,true));
       carToVins[_vin] = Car(_vin,true);
   }
   
   function getMyCarsCount() public view returns(uint) {
       return cars[msg.sender].length;
   }
   
   function getMyCar(uint index) public view returns(string){
       return cars[msg.sender][index].vin;
   }
   
   function getCarByVin(string _vin) public view returns(bool){
       return carToVins[_vin].isExist;
   }
   
   function addRepair(string _vin, string _repair) public {
       Repair memory newRepair;
       newRepair.service = msg.sender;
       newRepair.repair = _repair;
       newRepair.timestamp = block.timestamp;
       
       carToRepairs[_vin].push(newRepair);
   }
   
   function getRepairsCount(string _vin) public view returns(uint256){
       return carToRepairs[_vin].length;
   }
   
   function getRepair(string _vin,uint256 index) public view returns(address,string,uint256){
       Repair memory repair = carToRepairs[_vin][index];
       return (repair.service, repair.repair, repair.timestamp);
   }
}