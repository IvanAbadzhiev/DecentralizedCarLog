pragma solidity ^0.4.18;

contract CarLog {
    struct Car {
        string make;
        string model;
        uint256 year;
        string vin;
        address owner;
    }
    
    //Car[] cars[];
    mapping (address => Car[]) cars;
    uint256 numCars; //car counters
    
    mapping (address => uint256) private carOwners;
    
    address private contractOwner;
    
    function CarLog() public{
        contractOwner = msg.sender;
        
        //add temporary data
        cars[msg.sender][getCountOwnerCars() + 1] = Car("VW","Passat",1999,"vin",msg.sender);
    }
    
    function addCar(string _make, string _model, uint256 _year, string _vin) public {
        cars[msg.sender][getCountOwnerCars(msg.sender) + 1] = Car(_make, _model, _year, _vin, msg.sender);
        numCars++;
    }
    
    function getCar(string _vin) public view returns(string) {
        Car[] carsPerOwner;
        for(uint16 i = 0; i < cars[msg.sender].length; i++){
            return cars[msg.sender][i].vin;
            //if(cars[msg.sender][i].vin == _vin){
             //   carsPerOwner.push(Car(cars[msg.sender].make,cars[msg.sender].model,cars[msg.sender].year));
            //}    
        }
    }
    
    function getCarsCount() public view returns(uint256){
        return numCars;
    }
    
    function getCountOwnerCars(address _owner) internal returns(uint256){
        return cars[_owner].length;
    }
    
    function changeOwner(address newOwner, string _vin){
        //check owner
    }
}