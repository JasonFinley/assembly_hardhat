// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9 <0.9.0;

import "hardhat/console.sol";
/*
console.logInt(int i)
console.logUint(uint i)
console.logString(string memory s)
console.logBool(bool b)
console.logAddress(address a)
console.logBytes(bytes memory b)
console.logBytes1(bytes1 b)
console.logBytes2(bytes2 b)
*/

// Bitset
contract CardMiniBitmap {

    mapping(address => uint8) userBitmap;
    mapping(address => uint8) userBitmapAsm;

    function myCardBitmap() public view returns(uint8) {
        return userBitmap[msg.sender];
    }
    function myCardBitmapAsm() public view returns(uint8) {
        return userBitmapAsm[msg.sender];
    }

    function addAllCard() public {
        userBitmap[msg.sender] = 0xff;
    }

    /// 01010001 | 00000100 = 01010101
    function addCard(uint8 num) public {
        userBitmap[msg.sender] |= (uint8(1) << num);
    }
//execution cost	44955 gas
//[2,4,5,6,7,8,9,10] execution cost	46323 gas
    function addCardsAsm(uint8[] calldata nums) public {

        address msgSender = msg.sender;
//        uint8 ownerSum = userBitmapAsm[msg.sender];
        assembly{

            mstore(0x00, msgSender)
            mstore(0x20, userBitmapAsm.slot)

            let hash := keccak256( 0x00, 0x40 )
            let sum := sload( hash )
            let len := nums.length
            
            for { let i := 0 }
                lt( i, len )
                { i := add( i, 1 ) }
            {
                sum := or( sum, shl( calldataload( add( nums.offset, mul(i, 0x20) ) ), 1 ) )
            }

            sstore( hash, sum )
        }
//        userBitmapAsm[msg.sender] = uint8( num );
    }
//execution cost	46177 gas
//[2,4,5,6,7,8,9,10] execution cost	53101 gas
    function addCards(uint8[] calldata nums) public {
        for (uint i = 0; i < nums.length; i++) {
            userBitmap[msg.sender] |= (uint8(1) << nums[i]);
        }
    }

    function ownedCard(uint8 num) public view returns(bool) {
        return (userBitmap[msg.sender] & (uint8(1) << num)) > 0;
    }

    /// 01010101 & 00000100 = 00000100
    function ownedCards(uint8[] calldata nums) public view returns(bool) {
        uint8 mask = 0;
        for (uint i = 0; i < nums.length; i++) {
            mask |= (uint8(1) << nums[i]);
        }
        return (userBitmap[msg.sender] & mask) == mask;
    }

    function removeAllCard() public {
        userBitmap[msg.sender] = 0;
    }

    /// 01010101 & 00000100 = 00000100
    /// 01010101 ^ 00000100 = 01010001
    function removeCard(uint8 num) public {
        uint8 mask = uint8(1) << num;
        if ((userBitmap[msg.sender] & mask) > 0) {
            userBitmap[msg.sender] ^= mask;
        }
    }

    function removeCards(uint8[] calldata nums) public {
        uint8 temp = userBitmap[msg.sender];
        for (uint i = 0; i < nums.length; i++) {
            uint8 mask = uint8(1) << nums[i];
            if ((temp & mask) == mask) {
                temp ^= mask;
            }
        }

        if (userBitmap[msg.sender] != temp) {
            userBitmap[msg.sender] = temp;
        }
    }

    function toString(uint8 num) public pure returns(string memory) {
        bytes memory temp = new bytes(8);
        unchecked {
            for (uint i = 0; i < 8; i++) {
                temp[7 - i] = num & uint8(1) > 0 ? bytes1("1") : bytes1("0");
                num = num >> 1;
            }
        }
        return string(temp);
    }

    function toUint8(string calldata str) public pure returns(uint8) {
        bytes memory temp = bytes(str);
        require(temp.length == 8, "string lengh not invalid");
        uint8 num = 0;
        unchecked {
            for (uint i = 0; i < temp.length; i++) {
                if (temp[i] == "1") {
                    num |= uint8(1) << uint8(7 - i);
                }
            }
        }
        return num;
    }

    function get99CradsNum() public pure returns(uint256) {
        return uint256(633825300114114700748351602687);
    }

    function compare99CradsNum(uint num) public pure returns(bool) {
        uint result = (uint(1) << num) - 1;
        uint cards99 = get99CradsNum();
        return (cards99 & result) == cards99;
    }

    function get100CradsNum() public pure returns(uint256) {
        return uint256(1267650600228229401496703205375);
    }

    function compare100CradsNum(uint num) public pure returns(bool) {
        uint result = (uint(1) << num) - 1;
        uint cards100 = get100CradsNum();
        return (cards100 & result) == cards100;
    }

    function shiftLeft(uint8 num, uint8 shift) public pure returns(uint8, string memory) {
        uint8 result = num << shift;
        return (result, toString(result));
    }

    function shiftRight(uint8 num, uint8 shift) public pure returns(uint8, string memory) {
        uint8 result = num >> shift;
        return (result, toString(result));
    }

    function operatorNOT(uint8 num) public pure returns(uint8, string memory) {
        uint8 result = ~num;
        return (result, toString(result));
    }

    function operatorAND(uint8 num1, uint8 num2) public pure returns(uint8, string memory) {
        uint8 result = num1 & num2;
        return (result, toString(result));
    }

    function operatorOR(uint8 num1, uint8 num2) public pure returns(uint8, string memory) {
        uint8 result = num1 | num2;
        return (result, toString(result));
    }

        function operatorXOR(uint8 num1, uint8 num2) public pure returns(uint8, string memory) {
        uint8 result = num1 ^ num2;
        return (result, toString(result));
    }
}