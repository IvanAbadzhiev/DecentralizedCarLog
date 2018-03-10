pragma solidity ^0.4.18;

contract CarService {
    
    struct Service {
        address owner;
        string name;
        string image;
        bool isExist;
    }
    
    mapping(address => Service) private services;
    address[] private servicesIndex;
    
    address private contractOwner;
    
    modifier onlyOwner(){
        require(contractOwner == msg.sender);
        _;
    }

    modifier valueMustBeOverTax(){
        require (msg.value >= 1 ether);
        _;
    }
    
    modifier onlyOneCarServicePerAddress(){
        require(services[msg.sender].isExist == false);
        _;
    }
    
    modifier onlyServiceOwner(address _address){
        require(_address == services[_address].owner);
        _;
    }
    
    /* Events */
    event NewAutoService(string name);
    
    function CarService() public payable {
        contractOwner = msg.sender;
    }
    
    function addService(string name, string image) 
                        onlyOneCarServicePerAddress valueMustBeOverTax public payable {
        emit NewAutoService(name);
        servicesIndex.push(msg.sender);
        services[msg.sender] = Service(msg.sender,name,image,true);
    }
    
    function getServiceByAddress(address _address) public view returns(bool){
        return services[_address].isExist;
    }
    
    function getService(uint index) public view returns(string, string, address) {
        Service memory service = services[servicesIndex[index]];
        return (service.name, service.image, service.owner);
    }
    
    function getServicesLength() public constant returns(uint256){
        return servicesIndex.length;
    }
    
    function () payable public { }
    
    function kill () public onlyOwner {
        selfdestruct(msg.sender);
    }
}