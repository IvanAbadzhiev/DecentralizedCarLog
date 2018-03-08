pragma solidity ^0.4.18;

contract CarService {
    
    struct Service {
        address owner;
        string name;
        string image;
        bool isExist;
    }
    
    mapping(address => Service) public services;
    address[] public servicesIndex;
    
    address private owner;
    uint256 serviceTax = 100;
    
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }

    modifier valueMustBeOverTax(){
        require (msg.value >= serviceTax);
        _;
    }
    
    modifier onlyOneCarServicePerAddress(){
        require(services[msg.sender].isExist == false);
        _; // TODO:
    }
    
    modifier onlyServiceOwner(address _address){
        require(_address == services[_address].owner);
        _;
    }
    
    function CarService() public {
        owner = msg.sender;
    }
    
    function addService(string name, string image) onlyOwner onlyOneCarServicePerAddress valueMustBeOverTax public payable {
        servicesIndex.push(msg.sender);
        services[msg.sender] = Service(msg.sender,name,image,true);
    }
    
    function getService(uint index) public view returns(string, string) {
        Service service = services[servicesIndex[index]];
        return (service.name, service.image);
    }
    
    function getServicesLength() public constant returns(uint256){
        return servicesIndex.length;
    }
}