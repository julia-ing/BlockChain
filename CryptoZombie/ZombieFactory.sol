pragma solidity ^0.8.0; // 버전 

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna); // 이벤트 선언

    uint dnaDigits = 16; // 상태변수
    uint dnaModulus = 10 ** dnaDigits; // 10^16 지수연산

    struct Zombie { // 좀비 구조체
        string name;
        uint dna;
    }

    Zombie[] public zombies; // public 구조체 동적 배열

    mapping (uint => address) public zombieToOwner; // 매핑 선언
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string _name, uint _dna) internal { // private -> internal
        // 마지막에 추가된 좀비의 인덱스를 얻기 위해 -1 을 해준다
        uint id = zombies.push(Zombie(_name, _dna)) - 1; // 구조체 생성 후 push 로 배열에 순차 추가
        zombieToOwner[id] = msg.sender; // msg.sender 전역 변수 이용 - 보안과 관련
        ownerZombieCount[msg.sender]++;
        // 이벤트 실행
        NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) { // view 제어자, 반환값은 uint형
        uint rand = uint(keccak256(_str)); // 해시함수, 형변환
        return rand % dnaModulus; // 16자리 -> 나머지 연산
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0); // 좀비를 한번만 만들 수 있도록 require 이용해 조건 필터
        uint randDna = _generateRandomDna(_name); // 위 두 함수를 이용
        _createZombie(_name, randDna);
    }

}

