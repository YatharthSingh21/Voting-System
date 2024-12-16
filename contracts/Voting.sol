// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address Admin = msg.sender;
    mapping(bytes32 => uint256) private candidate_to_votes;
    mapping(address => bool) private hasVoted;
    mapping(address => bool) private valid_voter;
    mapping(bytes32 => bool) private valid_candidate;

    bytes32[] private candidateList;
    bytes32 private winner;
    uint256 private max_votes;

    function addCandidate(bytes32 _name) public {
        require(msg.sender==Admin, "You are not authorized to add candidates");
        require(_name.length > 0, "Please add the name");
        candidateList.push(_name);
        valid_candidate[_name] = true;
    }

    function addVoter(address walletAddress) public {
        require(msg.sender==Admin, "You are not authorized to add voters");
        require(walletAddress != address(0), "Invalid voter address");
        valid_voter[walletAddress] = true;
    }

    function castVote(bytes32 _name) public {
        require(valid_voter[msg.sender], "You are not a valid voter");
        require(!hasVoted[msg.sender], "You have already voted");
        require(valid_candidate[_name], "Candidate does not exist");

        candidate_to_votes[_name]++;
        hasVoted[msg.sender] = true;
        if(candidate_to_votes[_name]>max_votes){
            winner = _name;
            max_votes = candidate_to_votes[_name];
        }
    }

    function getVoteCount(bytes32 _name) public view returns (uint256 votes) {
        require(valid_candidate[_name], "Candidate does not exist");
        return candidate_to_votes[_name];
    }

    function view_winner() public view returns(bytes32 w){
        return winner;
    }

    function getCandidatesList() public view returns (bytes32[] memory list) {
        return candidateList;
    }
}
