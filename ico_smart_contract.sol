// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.4.11;

contract mycoin_ico {
    // Max number of mycoins available for sale
    uint256 public max_mycoins = 1000000;

    // Usd to mycoins conversion rate
    uint256 public usd_to_mycoins = 1000;

    // Total number of mycoins that have been bought by the investor
    uint256 public total_mycoins_bought = 0;

    // Mapping from the investor address to its quity in mycoins and Usd
    mapping(address => uint256) equity_mycoins;
    mapping(address => uint256) equity_usd;

    // check if investor can buy mycoins
    modifier can_buy_mycoins(uint256 usd_invested) {
        require(
            usd_invested * usd_to_mycoins + total_mycoins_bought <= max_mycoins
        );
        _;
    }

    // Getting the equity in mycoins of an investor
    function equity_in_mycoins(address investor)
        external
        constant
        returns (uint256)
    {
        return equity_mycoins[investor];
    }

    // Getting the equity in USD of an investor
    function equity_in_usd(address investor)
        external
        constant
        returns (uint256)
    {
        return equity_usd[investor];
    }

    // Buying mycoins
    function buy_mycoins(address investor, uint256 usd_invested)
        external
        can_buy_mycoins(usd_invested)
    {
        uint256 mycoins_bought = usd_invested * usd_to_mycoins;
        equity_mycoins[investor] += mycoins_bought;
        equity_usd[investor] = equity_mycoins[investor] / 1000;
        total_mycoins_bought += mycoins_bought;
    }

    // Selling mycoins
    function sell_mycoins(address investor, uint256 mycoins_sold) external {
        equity_mycoins[investor] -= mycoins_sold;
        equity_usd[investor] = equity_mycoins[investor] / 1000;
        total_mycoins_bought -= mycoins_sold;
    }
}
