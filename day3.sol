pragma solidity ^0.7.1;


contract StartStopUpdateContract{


    address owner;

    bool public paused;

    // creator of contract becomes the owner
    constructor() public {
        owner = msg.sender;
    }

    // lock money in contract
    function sendMoney() public payable {

    }

    // pause contract
    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;

    }

    // require address to be owner and the contract to not be paused to withdraw locked assets
    function withdrawAllMoney(address payable _to) public {

        require(msg.sender == owner, "You are not the owner");
        require(!paused, "Contract is paused");
        _to.transfer(address(this).balance);
    }

    // require address to be owner in order to self-destruct
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
}
