// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    event NewWave(address indexed from, uint256 timestamp, string message);

    uint256 totalWaves;
    /*
        Generate random number
    */
    uint256 private seed;
    mapping(address => uint256) public lastWavedAt;

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log("I AM A SMART CONTRACT. POGGERS");

        // initial seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Wait 15m");
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        /*
            Generate a new seed for the next user that sends a wave
        */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        /*
            Give a 50% chance the user wins the prize.
        */
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );

            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "failed to withdraw money from contract.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
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
