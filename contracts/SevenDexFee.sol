//SPDX-License-Identifier: MIT
pragma solidity =0.5.16;

import './interfaces/ISevenDexFee.sol';

contract SevenDexFee is ISevenDexFee {
    address public feeSetter;
    uint public fee;

    constructor(address _feeSetter) public {
        fee = 300;
        feeSetter = _feeSetter;
    }

    function setFee(uint _fee) external {
        require(msg.sender == feeSetter, 'SevenDexFee: FORBIDDEN');
        require(fee <= 1000, 'SevenDexFee: range from 0 ~ 1000');
        fee = _fee;
    }

    function setFeeTo(address _feeSetter) external {
        require(msg.sender == feeSetter, 'SevenDexFee: FORBIDDEN');
        feeSetter = _feeSetter;
    }
}