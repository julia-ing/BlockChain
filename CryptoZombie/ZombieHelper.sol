pragma solidity ^0.8.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require (zombies[_zombieId].level >= _level);
    _;
  }
  
  // 인수를 갖는 제어자 사용 
  function changeName(uint _zombieId, string _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  // 사용자의 좀비 군대 반환 - for 문 사용
  function getZombiesByOwner(address _owner) external view returns (uint []) { // view 사용해 가스 절약
    uint[] memory result = new uint[](ownerZombieCount[_owner]); // mapping 이용, 오너좀비가 소유한 좀비 개수
    
    uint counter = 0; // index
    for (uint i=0; i<zombies.length; i++) { // storage 에서 어떤 배열도 재정렬할 필요가 없기 때문에 비용 소모 줄일 수 있음
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }

    return result;
  }

}
