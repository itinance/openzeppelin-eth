pragma solidity ^0.5.2;

import "zos-lib/contracts/Initializable.sol";
import "./SafeERC20.sol";

/**
 * @title TokenTimelock
 * @dev TokenTimelock is a token holder contract that will allow a
 * beneficiary to extract the tokens after a given release time
 */
contract TokenTimelock is Initializable {
    using SafeERC20 for IERC20;

    // ERC20 basic token contract being held
    IERC20 private _token;

    // beneficiary of tokens after they are released
    address private _beneficiary;

    // timestamp when token release is enabled
    uint256 private _releaseTime;

    function initialize (IERC20 token, address beneficiary, uint256 releaseTime) public initializer {
        // solhint-disable-next-line not-rely-on-time
        require(releaseTime > block.timestamp);
        _token = token;
        _beneficiary = beneficiary;
        _releaseTime = releaseTime;
    }

    /**
     * @return the token being held.
     */
    function token() public view returns (IERC20) {
        return _token;
    }

    /**
     * @return the beneficiary of the tokens.
     */
    function beneficiary() public view returns (address) {
        return _beneficiary;
    }

    /**
     * @return the time when the tokens are released.
     */
    function releaseTime() public view returns (uint256) {
        return _releaseTime;
    }

    /**
     * @notice Transfers tokens held by timelock to beneficiary.
     */
    function release() public {
        // solhint-disable-next-line not-rely-on-time
        require(block.timestamp >= _releaseTime);

        uint256 amount = _token.balanceOf(address(this));
        require(amount > 0);

        _token.safeTransfer(_beneficiary, amount);
    }

    uint256[50] private ______gap;
}
