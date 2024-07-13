// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Verifier.sol"; // Import the ZKP verifier contract

contract VotingZKP {
    Verifier verifier; // Verifier contract instance

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    uint public candidatesCount;
    mapping(address => bool) public voters;

    event votedEvent(uint indexed candidateId);

    constructor(address _verifier) {
        verifier = Verifier(_verifier);
        addCandidate("Alice");
        addCandidate("Bob");
    }

    function addCandidate(string memory name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
    }

    function verifyAndVote(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[1] memory input,
        uint candidateId
    ) public {
        require(!voters[msg.sender], "You have already voted.");
        require(verifier.verifyProof(a, b, c, input), "Invalid ZKP proof.");

        voters[msg.sender] = true;
        candidates[candidateId].voteCount++;
        
        emit votedEvent(candidateId);
    }
}
