/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;

interface IRandomGenerator {
    function random() external view returns (uint256);
}

interface IDODOMidPrice {
    function getMidPrice() external view returns (uint256 midPrice);
}

contract RandomGenerator {
    address[] internal pools;

    constructor(address[] memory _pools) public {
        for (uint256 i = 0; i < pools.length; i++) {
            pools.push(_pools[i]);
        }
    }

    function random() external view returns (uint256) {
        uint256 priceSum;
        for (uint256 i = 0; i < pools.length; i++) {
            priceSum += IDODOMidPrice(pools[i]).getMidPrice();
        }
        return uint256(keccak256(abi.encodePacked(blockhash(block.number-1), priceSum)));
    }
}
