const { expect } = require("chai");
const { ethers } = require("hardhat");

describe( "CardMiniBitmap", function () {

    it("CardMiniBitmap", async function () {

        const CardMiniBitmap = await ethers.getContractFactory("CardMiniBitmap");
        const cardminibitmap = await CardMiniBitmap.deploy();
        await cardminibitmap.deployed();

        let base_array = [5,4,2,3,1,0];
        await cardminibitmap.addCards( base_array );
        expect( await cardminibitmap.myCardBitmap() ).to.deep.equal( 63 );
    });

    it("CardMiniBitmapAsm", async function () {

        const CardMiniBitmap = await ethers.getContractFactory("CardMiniBitmap");
        const cardminibitmap = await CardMiniBitmap.deploy();
        await cardminibitmap.deployed();

        let base_array = [5,4,3,2,1,0];
        await cardminibitmap.addCardsAsm( base_array );
        expect( await cardminibitmap.myCardBitmapAsm() ).to.deep.equal( 63 );
    });
} );


