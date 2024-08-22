// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {ISwapRouter02} from "./interfaces/ISwapRouter02.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";

address constant SWAP_ROUTER_02 = 0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45;
address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

contract Swap {

    ISwapRouter02 private constant router = ISwapRouter02(SWAP_ROUTER_02);
    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);

    function swapExactInputSingleHop(
        uint256 amountIn, 
        uint256 amountOutMin
    ) external {
        weth.transferFrom(msg.sender, address(this), amountIn);
        weth.approve(address(router), amountIn);

        ISwapRouter02.ExactInputSingleParams memory params = ISwapRouter02.ExactInputSingleParams({
            tokenIn: WETH,
            tokenOut: DAI,
            fee: 3000,
            recipient: msg.sender,
            amountIn: amountIn,
            amountOutMinimum: amountOutMin, 
            sqrtPriceLimitX96: 0
        });

        router.exactInputSingle(params);


    }

    function swapExactOutputSingleHop() external {}
    
}
