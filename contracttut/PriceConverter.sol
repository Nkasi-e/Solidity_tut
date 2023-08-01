// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // when using remix but can be gotten from an npm library when working on a local code editor

// Library in solidity
// functiions in library are declared internal
// Library are similar to contracts but you can't declare any state variables and can't send ether, we can also use library to add more fuctionality to different values

library PriceConverter {
    //  address public ethAdress = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;

    // fn to get price in terms of usd
    function getPrice() internal view returns (uint256) {
        // NB: whenever we work with a contract we always need the ABI and the Address
        // ABI -> Application Binary Interface
        // Address 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        );
        // (uint80 roundId, int price, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData()

        (, int256 answer, , , ) = priceFeed.latestRoundData(); // unpacking the variables from latestRoundData() with , , ,
        // Price of ETH in terms of USD

        // want to match the decimals
        return uint256(answer * 1e10); // 1**10
    }

    function getVersion() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        );
        return priceFeed.version();
    }

    // fn to get conversion rate
    function getConversionRate(
        uint256 _ethAmout
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * _ethAmout) / 1e18;
        return ethAmountInUsd;
    }
}
