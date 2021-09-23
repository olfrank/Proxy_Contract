pragma solidity ^0.8.3;

import "../contracts/storage.sol";

contract Proxy is Storage{

    address public currentAddress;

    constructor (address _currentAddress) {
        currentAddress = _currentAddress;
    }

    function upgrade(address newAddress) public {
        currentAddress = newAddress;
    }

    //fallback function
    fallback () payable external {
        address implementation = currentAddress;
        require(currentAddress != address(0));
        bytes memory data = msg.data;

        //delegatecall every function call in DogsUpdated and using the scope/state of the proxy contract
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}