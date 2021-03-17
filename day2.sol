pragma solidity ^0.7.1;

contract MappingStructExample {

    // Payment datatype
    struct Payment {
        uint amount;
        uint timestamps;
    }

    // Balance datatype
    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived; // maps address to a balance

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // increase balanceReceived of the address who sends money to contract
    function sendMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;
        Payment memory payment = Payment(msg.value, block.timestamp);

        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        balanceReceived[msg.sender].numPayments++;
    }

    function sendAllMoney() public payable {

    }

    function partialWithdraw(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender].totalBalance >= _amount, "not enough funds");
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to) public {
        require(balanceReceived[msg.sender].totalBalance > 0, "No funds associated with this account."); // check,
        uint balanceToSend = balanceReceived[msg.sender].totalBalance; // effect
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend); // interact
    }

}
