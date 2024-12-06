// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ETHuntNFT.sol";

contract ETHunt {
    ETHuntNFT public nftContract;
    
    struct Hunt {
        string name;
        string description;
        uint256 startsAt;
        uint256 duration;
        address[] winners;
        uint256 noOfParticipants;
        mapping(address => uint256) participantToTokenId;
    }

    Hunt[] public hunts;
  
    
    event HuntCreated(
        uint256 indexed huntId,
        string name,
        string description,
        uint256 startsAt,
        uint256 duration
    );

    event HuntStarted(uint256 indexed huntId, uint256 startedAt);
    event HuntEnded(uint256 indexed huntId, uint256 endedAt);
    event NFTAwarded(uint256 indexed huntId, address recipient, uint256 tokenId);

    constructor(address _nftContractAddress) {
        nftContract = ETHuntNFT(_nftContractAddress);
    }


    function createHunt(
        string memory _name,
        string memory _description,
        uint256 startsAt,
        uint256 _duration

    ) public returns (uint256) {

        hunts.push();

        Hunt storage newHunt = hunts[hunts.length - 1];
        newHunt.name = _name;
        newHunt.description = _description;
        newHunt.startsAt = startsAt;
        newHunt.duration = _duration;
    
    
        uint256 huntId = hunts.length - 1;

        emit HuntCreated(
            huntId,
            _name,
            _description,
            block.timestamp,
            _duration
        );

        return huntId;
    }

    function registerForHunt(uint256 _huntId, address _recipient, string memory _tokenURI) public returns (uint256) {
        require(_huntId < hunts.length, "Hunt does not exist");
        // require(hunts[_huntId].startsAt > block.timestamp, "Hunt has started.");
        uint256 tokenId = nftContract.mintNFT(_recipient, _tokenURI);
        hunts[_huntId].noOfParticipants++;
        hunts[_huntId].participantToTokenId[_recipient] = tokenId;
        emit NFTAwarded(_huntId, _recipient, tokenId);
        return tokenId;
    }

    function getHunt(uint256 _huntId) public view returns (
        string memory name,
        string memory description,
        uint256 startedAt,
        uint256 duration
    ) {
        require(_huntId < hunts.length, "Hunt does not exist");
        Hunt storage hunt = hunts[_huntId];
        return (
            hunt.name,
            hunt.description,
            hunt.startsAt,
            hunt.duration
        );
    }

    //to add winners to hunt
    function addWinner(uint256 _huntId, address winner) public {
        require(_huntId < hunts.length, "Hunt does not exist");
        Hunt storage hunt = hunts[_huntId];  
        hunt.winners.push(winner);
    }

    function getTokenId(uint256 _huntId, address _recipient) public view returns (uint256) {
        require(_huntId < hunts.length, "Hunt does not exist");
        Hunt storage hunt = hunts[_huntId];
        return hunt.participantToTokenId[_recipient];
    }
}