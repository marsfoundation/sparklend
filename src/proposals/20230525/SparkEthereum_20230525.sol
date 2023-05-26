// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {IEngine, Rates, EngineFlags} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {SparkPayloadEthereum} from '../../SparkPayloadEthereum.sol';

/**
 * @title List rETH on Spark Ethereum
 * @author Phoenix Labs
 * @dev This proposal lists rETH on Spark Ethereum
 * Forum: https://forum.makerdao.com/t/2023-05-24-spark-protocol-updates/20958
 * Vote: TODO
 */
contract SparkEthereum_20230525 is SparkPayloadEthereum {

    address public constant RETH = 0xae78736Cd615f374D3085123A210448E74Fc6393;
    address public constant RETH_PRICE_FEED = 0x05225Cd708bCa9253789C1374e4337a019e99D56;

    function newListings() public pure override returns (IEngine.Listing[] memory) {
        IEngine.Listing[] memory listings = new IEngine.Listing[](1);

        listings[0] = IEngine.Listing({
            asset: RETH,
            assetSymbol: 'rETH',
            priceFeed: RETH_PRICE_FEED,
            rateStrategyParams: Rates.RateStrategyParams({
                optimalUsageRatio: _bpsToRay(45_00),
                baseVariableBorrowRate: 0,
                variableRateSlope1: _bpsToRay(7_00),
                variableRateSlope2: _bpsToRay(300_00),
                stableRateSlope1: 0,
                stableRateSlope2: 0,
                baseStableRateOffset: 0,
                stableRateExcessOffset: 0,
                optimalStableToTotalDebtRatio: 0
            }),
            enabledToBorrow: EngineFlags.ENABLED,
            stableRateModeEnabled: EngineFlags.DISABLED,
            borrowableInIsolation: EngineFlags.DISABLED,
            withSiloedBorrowing: EngineFlags.DISABLED,
            flashloanable: EngineFlags.ENABLED,
            ltv: 68_50,
            liqThreshold: 79_50,
            liqBonus: 7_00,
            reserveFactor: 15_00,
            supplyCap: 20_000,
            borrowCap: 2_400,
            debtCeiling: 0,
            liqProtocolFee: 10_00,
            eModeCategory: 1
        });

        return listings;
    }

}