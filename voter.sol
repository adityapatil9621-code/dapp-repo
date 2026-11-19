
 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Voting {

    string[] public candidates;

    mapping(string => uint) public votes;
    mapping(address => bool) public hasVoted;

    function addCandidate(string memory name) public {
        candidates.push(name);
    }

    function vote(string memory name) public {
        require(!hasVoted[msg.sender], "Already voted");

        bool found = false;

        for(uint i = 0; i < candidates.length; i++) {
            if(keccak256(bytes(candidates[i])) == keccak256(bytes(name))) {
                found = true;
                break;
            }
        }

        require(found, "Candidate not found");

        votes[name]++;
        hasVoted[msg.sender] = true;
    }

    function getVotes(string memory name) public view returns(uint) {
        return votes[name];
    }

    function getWinner() public view returns(string memory) {
        string memory winner = candidates[0];

        for(uint i = 1; i < candidates.length; i++) {
            if(votes[candidates[i]] > votes[winner]) {
                winner = candidates[i];
            }
        }

        return winner;
    }
}
