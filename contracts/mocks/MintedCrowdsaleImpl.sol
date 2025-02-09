pragma solidity ^0.5.2;

import "../token/ERC20/ERC20Mintable.sol";
import "../crowdsale/emission/MintedCrowdsale.sol";

contract MintedCrowdsaleImpl is MintedCrowdsale {
    constructor (uint256 rate, address payable wallet, ERC20Mintable token) public {
        Crowdsale.initialize(rate, wallet, token);
    }
}
