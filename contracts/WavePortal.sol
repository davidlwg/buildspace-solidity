// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() {
        console.log("I AM A SMART CONTRACT. POGGERS");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getWave() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    /*
    OLD SHIT
    */
//    uint256 totalWaves;
//    mapping(address => int) public wavesByAddy;
//
//    mapping(address => bool) public Addy;
//    address[] public allAddy;
//
//    constructor() {
//        console.log("Hello world!");
//    }
//
//    function add() public {
//        totalWaves += 1;
//
//        if (!Addy[msg.sender]) {
//            Addy[msg.sender] = true;
//            allAddy.push(msg.sender);
//        }
//
//        wavesByAddy[msg.sender]++;
//        console.log("%s has waved!", msg.sender);
//    }
//
//    function sub() public {
//        totalWaves -= 1;
//
//        if (!Addy[msg.sender]) {
//            Addy[msg.sender] = true;
//            allAddy.push(msg.sender);
//        }
//
//        wavesByAddy[msg.sender]--;
//        console.log("%s removed a wave!", msg.sender);
//    }
//
//    function getTotalWaves() public view returns (int256) {
//        console.log("total waves: ");
//        console.logInt(totalWaves);
//        return totalWaves;
//    }
//
//    function printAllAddys() public view {
//        console.log("All wallets that have called this contract:");
//        for (uint i = 0; i < allAddy.length; ++i) {
//            address curAddr = allAddy[i];
//            console.log(" ", curAddr);
//            console.logInt(wavesByAddy[curAddr]);
//        }
//    }
}
