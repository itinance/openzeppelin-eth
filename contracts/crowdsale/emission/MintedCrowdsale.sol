pragma solidity ^0.5.2;

import "zos-lib/contracts/Initializable.sol";
import "../Crowdsale.sol";
import "../../token/ERC20/ERC20Mintable.sol";

/**
 * @title MintedCrowdsale
 * @dev Extension of Crowdsale contract whose tokens are minted in each purchase.
 * Token ownership should be transferred to MintedCrowdsale for minting.
 */
contract MintedCrowdsale is Initializable, Crowdsale {
    /**
     * @dev Overrides delivery by minting tokens upon purchase.
     * @param beneficiary Token purchaser
     * @param tokenAmount Number of tokens to be minted
     */
    function _deliverTokens(address beneficiary, uint256 tokenAmount) internal {
        // Potentially dangerous assumption about the type of the token.
        require(ERC20Mintable(address(token())).mint(beneficiary, tokenAmount));
    }

    uint256[50] private ______gap;
}
