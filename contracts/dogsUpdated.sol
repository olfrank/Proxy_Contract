pragma solidity ^0.8.3;

import "../contracts/storage.sol";

contract DogsUpdated is Storage {

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    constructor() public {
       initialise(msg.sender);
    }

    function initialise(address _owner) public {
        require(!initialised);
        owner = _owner;
        initialised = true;
    }
    
    function getNumberOfDogs()public view returns(uint256){
        return _uintStorage["Dogs"];
    }

    function setNumberOfDogs(uint numberOf)public onlyOwner{
        _uintStorage["Dogs"] = numberOf;
    }



}