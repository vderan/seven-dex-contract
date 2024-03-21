// SPDX-License-Identifer: MIT
pragma solidity =0.5.16;

import './interfaces/ISevenDexFactory.sol';
import './SevenDexPair.sol';

contract SevenDexFactory is ISevenDexFactory {
    bytes32 public constant INIT_CODE_PAIR_HASH = keccak256(abi.encodePacked(type(SevenDexPair).creationCode));
    address public feeTo;
    address public feeToSetter;
    uint public fee;

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    constructor(address _feeToSetter) public {
        feeToSetter = _feeToSetter;
        fee = 5;
    }

    function allPairsLength() external view returns (uint) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, 'SevenDex: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'SevenDex: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'SevenDex: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(SevenDexPair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        ISevenDexPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, 'SevenDex: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, 'SevenDex: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }

    function setFee(uint _fee) external {
        require(msg.sender == feeToSetter, 'SevenDex: FORBIDDEN');
        fee = _fee;
    }
}