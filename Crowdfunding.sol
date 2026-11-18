// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Crowdfunding {

    address public owner;
    uint public fundingGoal;
    uint public deadline;
    uint public totalFunds;

    mapping(address => uint) public contributions;

    event ContributionReceived(address, uint);
    event GoalReached(uint);
    event RefundReceived(address, uint);

    constructor(uint _fundingGoal, uint _duration) {
        owner = msg.sender;
        fundingGoal = _fundingGoal;
        deadline = block.timestamp + _duration;
    }

    function dispo() public view returns(address) {
        return owner;
    }
}

contract CrowdfundingCampaign is Crowdfunding {

    constructor(uint _fundingGoal, uint _duration)
        Crowdfunding(_fundingGoal, _duration) {}

    function contribute() public payable {
        require(block.timestamp < deadline, "Campaign ended");
        require(msg.value > 0, "Invalid contribution");

        totalFunds += msg.value;
        contributions[msg.sender] += msg.value;

        emit ContributionReceived(msg.sender, msg.value);

        if(totalFunds >= fundingGoal) {
            emit GoalReached(totalFunds);
        }
    }

    function refund() public {
        require(block.timestamp >= deadline, "Campaign not ended");
        require(totalFunds < fundingGoal, "Goal reached");

        uint amount = contributions[msg.sender];
        require(amount > 0, "No contribution");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amount);

        emit RefundReceived(msg.sender, amount);
    }
}
