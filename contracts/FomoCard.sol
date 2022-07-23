// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract FomoCard is ERC721 {
    constructor() ERC721("FomoCard", "FOMO") {}

    mapping(address => uint256) collectMap;

    function getCollectTar( address tar ) public view returns ( uint256 ) {
        return collectMap[ tar ];
    }
//execution cost	24579 gas
    function removeCardAsm(address tar, uint256 tokenId) public {
        // burn
        if (tar == address(0)) {
            return;
        }
        require(tokenId < 256, "TokenId out of range");

        assembly {
            mstore(0x00, tar)
            mstore(0x20, collectMap.slot)
            let hash := keccak256( 0x00, 0x40 )
            let collect := sload( hash )
            let mask := shl( tokenId, 1 )
            switch and( collect, mask )
                case 0
                    {}
                default
                {
                    sstore( hash, xor( collect, mask ) )
                }
        }
    }    
//execution cost	27551 gas    
    function removeCard(address tar, uint256 tokenId) public {
        // burn
        if (tar == address(0)) {
            return;
        }
        require(tokenId < 256, "TokenId out of range");
        uint256 collect = collectMap[tar];
        uint256 mask = uint256(1) << tokenId;
        if ((collect & mask) > 0) {
            collectMap[tar] = collect ^ mask;
        }
    }
//execution cost	27447 gas
//execution cost	44547 gas
    function addCardAsm(address tar, uint256 tokenId) public {
        // mint
        if (tar == address(0)) {
            return;
        }
        require(tokenId < 256, "TokenId out of range");

        assembly {
            mstore( 0x00, tar)
            mstore( 0x20, collectMap.slot )
            let hash := keccak256( 0x00, 0x40 )
            let collect := sload( hash )
            let mask := shl( tokenId, 1 )
            if iszero( and( collect, mask ) ){
                sstore( hash, or( collect, mask ) )
            }
        }

    }
//execution cost	27635 gas
//execution cost	44735 gas
    function addCard(address tar, uint256 tokenId) public {
        // mint
        if (tar == address(0)) {
            return;
        }
        require(tokenId < 256, "TokenId out of range");
        uint256 collect = collectMap[tar];
        uint256 mask = uint256(1) << tokenId;
        if ((collect & mask) == 0) {
            collectMap[tar] = collect | mask;
        }
    }

    function IsChampion(address tar) public view returns(bool) {
        uint256 allCards = 1267650600228229401496703205375;
        uint256 collect = collectMap[tar];
        return (collect & allCards) == allCards;
    }
}