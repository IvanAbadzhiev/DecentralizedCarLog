pragma solidity ^0.4.18;

contract CarService {
    struct Service {
        address owner;
    }
    
    mapping(uint256 => Service) services;
    address[] servicesArr;
    
    
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
    
    function addService() onlyOwner valueMustBe1Ether public payable {
        servicesArr.push(msg.sender);
        services[1] = Service(msg.sender);
    }
    
    function getServicesLength() constant returns(uint256){
        return servicesArr.length;
    }
}