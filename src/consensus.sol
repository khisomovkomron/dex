// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.20;

contract Storage1 {
    address public owner;
    mapping(address => bytes) public authUsers;
    mapping(bytes32 => address) public authUsersLookup;

    uint256 private important;

    event ImpSet(address _whoBy, uint256 _val);

    modifier onlyAuthUsers() {
        require(authUsers[msg.sender].length != 0, "User not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addAuthUser(address _authUser, bytes calldata _name) public {
        require(msg.sender == owner);
        require(_name.length != 0, "Invalid name");
        bytes32 nameHash = keccak256(abi.encodePacked(_name));
        authUsers[_authUser] = _name;
        authUsersLookup[nameHash] = _authUser;
    }

    function revokeAuthUser(address _authUser) public {
        require(msg.sender == owner);
        delete authUsers[_authUser];
    }

    function setImportant(uint256 _important) external onlyAuthUsers {
        important = _important;
        emit ImpSet(msg.sender, _important);
    }
}
