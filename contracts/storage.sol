pragma solidity ^0.8.3;

contract Storage {
    
    mapping(string => uint256) _uintStorage;
    mapping(string => address) _addressStorage;
    mapping(string => bytes4) _bytesStorage;
    mapping(string => string) _stringStorage;
    mapping(string => bool) _boolStorage;

    address public owner;
    bool public initialised;

}