pragma solidity ^0.4.18;

contract CarService {
    
    struct Service {
        address owner;
        string name;
    }
    
    event Status(uint indexed statusCode);
    
    mapping(address => Service) public services;
    address[] public servicesArr;
    
    address private owner;
    uint256 serviceTax = 100;
    
    modifier onlyOwner(){
        Status(1); // only owner log
        require(owner == msg.sender);
        _;
    }

    modifier valueMustBeOverTax(){
        Status(2); // value must be over tax
        require (msg.value >= serviceTax);
        _;
    }
    
    modifier onlyOneCarServicePerAddress(address _address){
        _; // TODO:
    }
    
    modifier onlyServiceOwner(address _address){
        require(_address == services[_address].owner);
        _;
    }
    
    function CarService() public {
        owner = msg.sender;
    }
    
    function addService(string name) onlyOwner valueMustBeOverTax public payable {
        servicesArr.push(msg.sender);
        services[msg.sender] = Service(msg.sender,name);
    }
    
    function getServices() public view returns(address[]) {
        return servicesArr;
    }
    
    function getServicesLength() public constant returns(uint256){
        return servicesArr.length;
    }
    
    function removeService() public onlyServiceOwner(msg.sender) {
        delete services[msg.sender];
    }
}