pragma solidity ^0.4.18;

contract CarLog {
    struct Car {
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
        cars[msg.sender].push(Car("vin",msg.sender));
        numCars++;
        //cars[msg.sender] = Car("vin",msg.sender);
    }
    
    function addCar(string _vin) public {
        cars[msg.sender][getCountOwnerCars(msg.sender) + 1] = Car(_vin, msg.sender);
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
    
    function getCountOwnerCars(address _owner) public view returns(uint256){
        return cars[_owner].length;
    }
    
    function changeOwner(address newOwner, string _vin){
        //check owner
    }
}