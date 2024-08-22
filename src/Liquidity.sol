// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {INonfungiblePositionManager} from "./interfaces/INonfungiblePositionManager.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";
import {IERC721Receiver} from "../lib/openzeppelin-contracts/contracts/interfaces/IERC721Receiver.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

contract Liquidity is IERC721Receiver{
    IERC20 private constant dai = IERC20(DAI);
    IWETH private constant weth = IWETH(WETH);
}
