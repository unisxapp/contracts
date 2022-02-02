// SPDX-License-Identifier: MIT

pragma solidity ^0.8;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./LPStakingRewards.sol";

contract LPStakingRewardsFactory is Ownable {

    mapping(address => address) public stakingRewards;

    event LPStakingRewardsCreated(
      address indexed _stakingToken,
      address _rewardsToken,
      uint _rewardRate,
      uint _periodFinish
    );

    function createLPStakingRewards(
      address _stakingToken,
      address _rewardsToken,
      uint _rewardRate,
      uint _periodFinish
    ) external onlyOwner() {

      require(stakingRewards[_stakingToken] == address(0), 'already exists');

      LPStakingRewards rewards = new LPStakingRewards(
        _stakingToken, 
        _rewardsToken, 
        _rewardRate, 
        _periodFinish
      );

      stakingRewards[_stakingToken] = address(rewards);

      emit LPStakingRewardsCreated(
        _stakingToken, 
        _rewardsToken, 
        _rewardRate, 
        _periodFinish
      );
    }
}