pragma solidity ^0.4.21;
contract Election {
    struct Candidate{
        string name;
        uint voteCount;
    }
    struct Voter{
        bool authroized;
        bool voted;
        uint vote;
    }
    address public owner;
    string public electionName;
    mapping(address=> Voter) public voters;
    Candidate[] public candidates;
    uint public totalVotes;
    
    modifier ownerOnly(){
        require(msg.sender==owner);
        _;
    }
    
    function Election(string _name)public{
        owner=msg.sender;
        electionName=_name;
    }
    function addCandidate(string _name)public{
        candidates.push(Candidate(_name,0));
    }
    
    function getNumCandidate() public view returns(uint){
        return candidates.length;
    }
    
    function authroize(address _person)ownerOnly public{
        voters[_person].authroized=true;
    }
    
    function vote(uint _voteindex)public{
        require(!voters[msg.sender].voted);
        require(voters[msg.sender].authroized);
        voters[msg.sender].vote=_voteindex;
        voters[msg.sender].voted=true;
        candidates[_voteindex].voteCount+=1;
        totalVotes+=1;
        
    }
    
    function end()ownerOnly public{
        selfdestruct(owner);
    }
    
}
