//SPDX-License-Identifier: MIT
//contracts/Logbookd.sol

pragma solidity ^0.8.4;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Logbookd is Ownable {
    constructor(address initOwner) Ownable(initOwner) {}

    uint256 internal userId = 0;

    //structure of each user
    struct User {
        string name;
        string usn;
        uint8 batch; //passing year (eg:2026)
        uint16 mobNum;
    }

    //user data mapping
    mapping(uint256 => User) internal userData;

    //events
    event userRegistered(uint _usrId); //emit when user is registered

    //add new user
    //onlyOwner so that it can only be called by a single address when using with account abstraction
    function addNewUser(
        string calldata _name,
        string calldata _usn,
        uint8 _batch,
        uint16 _mobNum
    ) public onlyOwner returns (bool) {
        require(bytes(_name).length > 0, "name required");
        require(bytes(_usn).length > 0, "usn required");
        require(_batch >= 2026, "batch must be after 2026");
        require(_mobNum > 0, "contact number required");
        //one more check pending to check if same usn exists in mapping

        User memory usr = User(_name, _usn, _batch, _mobNum);
        userData[userId] = usr;
        userId++;
        emit userRegistered(userId - 1);

        return true;
    }
}
