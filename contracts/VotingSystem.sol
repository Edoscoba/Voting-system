// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    struct Proposal {
        string description;
        uint voteCount;
    }

    address public admin;
    mapping(address => bool) public hasVoted;
    Proposal[] public proposals;
    bool public votingEnded;

    constructor(string[] memory proposalNames) {
        admin = msg.sender;
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                description: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    modifier voteOpen() {
        require(!votingEnded, "Voting has ended");
        _;
    }

    function vote(uint proposalIndex) public voteOpen {
        require(!hasVoted[msg.sender], "You have already voted");
        proposals[proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function endVoting() public onlyAdmin voteOpen {
        votingEnded = true;
    }

    function getWinningProposal() public view returns (uint winningProposal) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposal = i;
            }
        }
    }

    function getProposal(uint index) public view returns (string memory description, uint voteCount) {
        Proposal memory proposal = proposals[index];
        return (proposal.description, proposal.voteCount);
    }
}

