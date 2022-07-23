// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
import "hardhat/console.sol";

contract QuickSort {

    function quickSortAsm(uint[] memory arr, int left, int right ) internal pure {
        int l = left;
        int r = right;
        int pivot = 0;

        assembly {
            let arrayStart := add( arr, 0x20 )
            pivot := mload(add(arrayStart, mul(0x20, add(left, div(sub(right, left), 2)))))

            for {} iszero( gt( l, r ) ) {}
            {
                for {} lt( mload( add( arrayStart, mul( l, 0x20 ) ) ), pivot ) {}
                {
                    l := add( l, 1 )
                }

                for {} lt( pivot, mload( add( arrayStart, mul( r, 0x20 ) ) ) ) {}
                {
                    r := sub( r, 1 )
                }

                switch gt( l, r )
                 case 0 {
                    let lp := add( arrayStart, mul( l, 0x20 ) )
                    let rp := add( arrayStart, mul( r, 0x20 ) )
                    let temp := mload( lp )
                    mstore( lp, mload(rp) )
                    mstore( rp, temp)
                    l := add( l, 1 )
                    r := sub( r, 1 )
                 }
            }

        }

        if ( left < r )
            quickSortAsm(arr, left, r );
        if ( l < right )
            quickSortAsm(arr, l, right);

    }

    function sortAsm(uint[] memory data) public pure returns (uint[] memory){
        quickSortAsm( data, int(0), int(data.length - 1) );
        return data;
    }

    function sort(uint[] memory data) public pure returns (uint[] memory) {
        quickSort(data, int(0), int(data.length - 1));
        return data;
    }

    function quickSort(uint[] memory arr, int left, int right) internal pure {
        int i = left;
        int j = right;
        if (i == j) return;
        uint pivot = arr[uint(left + (right - left) / 2)];
        while (i <= j) {
            while (arr[uint(i)] < pivot) i++;
            while (pivot < arr[uint(j)]) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }

}