// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

interface ISevenDexFee {
    function fee() external view returns (uint);
    function feeSetter() external view returns (address);

    function setFee(uint) external;
    function setFeeTo(address) external;
}