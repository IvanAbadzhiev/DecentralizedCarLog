pragma solidity ^0.4.18;

contract CarLog {
    struct Car {
        string vin;
        address owner;
    }
    
    mapping(address => Car[]) private cars;
    mapping(string => Car) private carVins;
    mapping(string => address[]) private carToService;
    
    address private contractOwner;
  
    modifier onlyCarOwner(string _vin){
        require(carVins[_vin].owner == msg.sender);
        _;
    }
    
    function CarLog() public{
        contractOwner = msg.sender;
    }
    
   function addAcar(string _vin) public {
       cars[msg.sender].push(Car(_vin, msg.sender));
       carVins[_vin] = Car(_vin, msg.sender);
   }
   
   function getCar(string _vin) public view returns(string){
       return carVins[_vin].vin;
   }
   
   function addVehicleService(string _vin, address _address) public onlyCarOwner(_vin) {
       carToService[_vin].push(_address);
   }
   
   // TODO validation.
   // check is service already added
   // check address is not car owner
   function getVehicleServices(string _vin) public view onlyCarOwner(_vin) returns(address[]) {
       return carToService[_vin];
   }
   
   function getMyCars() public view returns(bytes32[]) {
       bytes32[] storage vins;
       
        for(uint i = 0; i < cars[msg.sender].length; i++){
            vins.push(stringToBytes32(cars[msg.sender][i].vin));
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