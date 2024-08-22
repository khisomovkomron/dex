// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
import {IERC20} from "../../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";


interface IWETH is IERC20 {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
}