const { expect } = require("chai");
const { ethers } = require("hardhat");

describe( "FomoCard", function () {

    it("Fomo Card addCard", async function () {

        const FomoCard = await ethers.getContractFactory("FomoCard");
        const fomocard = await FomoCard.deploy();
        await fomocard.deployed();
        const [ owner, otherAccount] = await ethers.getSigners();

        let id = 0;
        await fomocard.addCard( owner.address, id );
        expect( await fomocard.getCollectTar( owner.address ) ).to.deep.equal( 1 << id );
    });

    it("Fomo Card addCard by assembly", async function () {

        const FomoCard = await ethers.getContractFactory("FomoCard");
        const fomocard = await FomoCard.deploy();
        await fomocard.deployed();
        const [ owner, otherAccount] = await ethers.getSigners();

        let id = 0;
        await fomocard.addCardAsm( owner.address, id );
        expect( await fomocard.getCollectTar( owner.address ) ).to.deep.equal( 1 << id );
    });

    it("Fomo Card removeCard", async function () {

        const FomoCard = await ethers.getContractFactory("FomoCard");
        const fomocard = await FomoCard.deploy();
        await fomocard.deployed();
        const [ owner, otherAccount] = await ethers.getSigners();

        await fomocard.addCard( owner.address, 0 );
        await fomocard.addCard( owner.address, 1 );
        await fomocard.removeCard( owner.address, 0 );
        expect( await fomocard.getCollectTar( owner.address ) ).to.deep.equal( 1 << 1 );
    });

    it("Fomo Card removeCard by assembly", async function () {

        const FomoCard = await ethers.getContractFactory("FomoCard");
        const fomocard = await FomoCard.deploy();
        await fomocard.deployed();
        const [ owner, otherAccount] = await ethers.getSigners();

        await fomocard.addCardAsm( owner.address, 0 );
        await fomocard.addCardAsm( owner.address, 1 );
        await fomocard.removeCardAsm( owner.address, 0 );
        expect( await fomocard.getCollectTar( owner.address ) ).to.deep.equal( 1 << 1 );
    });

} );



