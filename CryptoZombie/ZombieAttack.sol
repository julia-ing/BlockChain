pragma solidity ^0.8.0;

import "./ZombieHelper.sol";

contract ZombieAttack is ZombieHelper {
  uint randNonce = 0;
  uint attackVictoryProbability = 70;
  
  function randMod(uint _modulus) internal returns(uint) {
    // randNonce++;
    randNonce = randNonce.add(1);
    // 난수 생성, keccak256 해시함수를 이용하며 % _modulus 로 마지막 몇자리만을 취한다
    return uint(keccak256(now, msg.sender, randNonce)) % _modulus;
  }

  // 함수 호출하는 사람이 _zombieId를 소유하고 있는지 확인하기 위해 attack 함수에 ownerOf 제어자 추가
  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100); // 난수 

    if (rand <= attackVictoryProbability) {
      // myZombie.winCount++;
      myZombie.winCount = myZombie.winCount.add(1); // 승
      myZombie.level = myZombie.level.add(1);
      enemyZombie.lossCount = enemyZombie.lossCount.add(1); // 패
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie"); // 함수 호출
    } else {
      myZombie.lossCount = myZombie.lossCount.add(1); // 패
      enemyZombie.winCount = enemyZombie.winCount.add(1); // 승
    }
    _triggerCooldown(myZombie); // 쿨다운 (좀비 재사용 대기 시간)
  }
}
