pragma solidity ^0.8.0;

import "./ZombieFactory.sol";

contract KittyInterface { // 크립토키티 인터페이스, read only만 가능하고 실제 데이터를 지울 수 없다
    function getKitty(uint256 _id) external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract ZombieFeeding is ZombieFactory {

    // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // KittyInterface kittyContract = KittyInterface(ckAddress); // 인터페이스 초기화

    KittyInterface kittyContract;

    function setKittyContractAddress(address _address) external onlyOwner { // external 은 누구든 호출 가능해 보안 취약점 존재 -> Ownable
        kittyContract = KittyInterface(_address);
    }

    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32(now + cooldownTime); // 대기 시간 1일
    }

    function _isReady(Zombie storage _zombie) internal view returns (bool) {
        return (_zombie.readyTime <= now); // 준비 상태인지 확인
    }

    function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) internal { // 보안상 public -> internal
        require(msg.sender == zombieToOwner[_zombieId]); // 좀비 주인만 먹이를 줄 수 있음
        Zombie storage myZombie = zombies[_zombieId]; // 영구 저장
        require(_isReady(myZombie)); // 좀비 재사용 대기 시간이 끝난 이후에만 이 함수 실행 가능 
        _targetDna = _targetDna % dnaModulus; // 16자리수 맞추기
        uint newDna = (myZombie.dna + _targetDna) / 2; // 새로운 dna 값 도출 - 평균

        if (keccak256(_species) == keccak256("kitty")) { // 만약 좀비가 고양이에서 생성되면
            newDna = newDna - newDna % 100 + 99; // 좀비 dna의  마지막 2자리를 99로 설정
        }

        _createZombie("NoName", newDna); // 함수 호출해서 새로운 좀비 생성
        _triggerCooldown(myZombie); // 재사용 대기 시간 생성    
    }

    function feedOnKitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); // 다수 반환값 처리, 마지막 genes를 갖고 옴
        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }

}
