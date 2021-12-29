// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    int256 totalWaves;
    mapping(address => int) public wavesByAddy;

    mapping(address => bool) public Addy;
    address[] public allAddy;

    constructor() {
        console.log("Hello world!");
    }

    function add() public {
        totalWaves += 1;

        if (!Addy[msg.sender]) {
            Addy[msg.sender] = true;
            allAddy.push(msg.sender);
        }

        wavesByAddy[msg.sender]++;
        console.log("%s has waved!", msg.sender);
    }

    function sub() public {
        totalWaves -= 1;

        if (!Addy[msg.sender]) {
            Addy[msg.sender] = true;
            allAddy.push(msg.sender);
        }

        wavesByAddy[msg.sender]--;
        console.log("%s removed a wave!", msg.sender);
    }

    function getTotalWaves() public view returns (int256) {
        console.log("total waves: ");
        console.logInt(totalWaves);
        return totalWaves;
    }

    function printAllAddys() public view {
        console.log("All wallets that have called this contract:");
        for (uint i = 0; i < allAddy.length; ++i) {
            address curAddr = allAddy[i];
            console.log(" ", curAddr);
            console.logInt(wavesByAddy[curAddr]);
        }
    }


    // rank wallets with the most waves
}
