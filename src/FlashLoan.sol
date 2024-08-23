// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {IUniswapV3Pool} from "../lib/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol";

contract FlashLoan {
    struct FlashCallbackData {
        uint256 amount0;
        uint256 amount1;
        address caller;
    }

    IUniswapV3Pool private immutable pool;
    IERC20 private immutable token0;
    IERC20 private immutable token1;

    constructor(address _pool) {
        pool = IUniswapV3Pool(_pool);
        token0 = IERC20(pool.token0);
        token1 = IERC20(pool.token1);
    }

    function flash(uint256 amount0, uint256 amount1) external {
        bytes memory data = abi.encode(
            FlashCallbackData({
                amount0: amount0,
                amount1: amount1,
                caller: msg.sender
            })
        );

        IUniswapV3Pool(pool).flash(address(this), amount0, amount1, data);
    }

    function uniswapV3FlashCallback(
        uint256 fee0,
        uint256 fee1, 
        bytes  calldata data
    ) external {
        require(msg.sender == address(pool), "Not authorized");
        FlashCallbackData memory decoded = abi.decode(data, (FlashCallbackData));

        if (fee0 > 0) {
            token0.transferFrom(decoded.caller, address(this), fee0);
        }
        if (fee1 > 0) {
            token1.transferFrom(decoded.caller, address(this), fee1);
        }

        if (fee0 > 0) {
            token0.transfer(address(pool), decoded.amount0 + fee0);
        }
        if (fee1 > 0) {
            token1.transfer(address(pool), decoded.amount1 + fee1);
        }
    }
}
