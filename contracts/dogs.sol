pragma solidity ^0.8.3;

import "../contracts/storage.sol";

contract Dogs is Storage {

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }
    
    function getNumberOfDogs()public view returns(uint256){
        return _uintStorage["Dogs"];
    }

    function setNumberOfDogs(uint numberOf)public {
        _uintStorage["Dogs"] = numberOf;
    }



}