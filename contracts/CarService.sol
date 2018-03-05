pragma solidity ^0.4.18;

contract CarService {
    struct Service {
        address owner;
        string name;
    }
    
    mapping(address => Service) public services;
    address[] public servicesArr;
    
    
    address private owner;
    
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }
    
    modifier valueMustBe1Ether(){
        require (msg.value >= 1000000000000000000);
        _;
    }
    
    function CarService() public {
        owner = msg.sender;
    }
    
    function addService(string name) onlyOwner valueMustBe1Ether public payable {
        servicesArr.push(msg.sender);
        services[msg.sender] = Service(msg.sender,name);
    }
    
    function getServices() public view returns(address[]) {
        return servicesArr;
    }
    
    function getServicesLength() public constant returns(uint256){
        return servicesArr.length;
    }
}