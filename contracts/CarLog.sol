pragma solidity ^0.4.18;

contract CarLog  {
    
    struct Car {
        string vin;
        address owner;
    }
    
    struct Owner {
        address owner;
        Car[] cars;
    }
    
    mapping(address => mapping (string => Car)) cars;
    mapping(string => address) vinToAddress;
    mapping(address => Car[]) carToOwners;
    
    address private contractOwner;
    
    function CarLog() public{
        contractOwner = msg.sender;
    }
    
    function addCar(string _vin){
        cars[msg.sender][_vin] =  Car(_vin, msg.sender);
        vinToAddress[_vin] = msg.sender;
        carToOwners[msg.sender].push(Car(_vin, msg.sender));
    }
    
    function getCar(string _vin) public view returns(string){
        return cars[vinToAddress[_vin]][_vin].vin;
    }
    
    function getCarsByOwner() public view returns( bytes32[] ) {
        bytes32[] vins;
        
        for(uint i = 0; i < carToOwners[msg.sender].length; i++){
            vins.push(stringToBytes32(carToOwners[msg.sender][i].vin));
        }
        
        return vins;
   }
    
    function stringToBytes32(string memory source) public view returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }
    }
}