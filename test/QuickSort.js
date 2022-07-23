const { expect } = require("chai");
const { ethers } = require("hardhat");

describe( "QuickSort", function () {

    it("check quick sort", async function () {

        const QuickSort = await ethers.getContractFactory("QuickSort");
        const quicksort = await QuickSort.deploy();
        await quicksort.deployed();
    
        let base_array = [5,4,2,8,1,9,0];
        let ans_array = [0,1,2,4,5,8,9];

        expect(await quicksort.sort( base_array )).to.deep.equal( ans_array );
    });

    it("check quick sort by assembly", async function () {

        const QuickSort = await ethers.getContractFactory("QuickSort");
        const quicksort = await QuickSort.deploy();
        await quicksort.deployed();
    
        let base_array = [5,4,2,8,1,9,0];
        let ans_array = [0,1,2,4,5,8,9];

        expect( await quicksort.sortAsm( base_array ) ).to.deep.equal( ans_array );
    });

} );



