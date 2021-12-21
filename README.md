# BlockChain

## CryptoZombies 
<details>
<summary>Lesson1 Sum-Up</summary>
<div markdown="1">       

- **상태변수** : 
    컨트랙트 저장소에 영구적으로 저장 (이더리움 블록체인에 기록됨)

- **구조체**: 
    여러 특성을 가진, 보다 복잡한 자료형 생성

- **배열**

    1. 정적 배열 : string[5] stringArray;
    2. 동적 배열 : uint[] dynamicArray;
    구조체의 동적 배열을 생성하면 (db처럼) 컨트랙트에 구조화된 데이터를 저장하는 데 유용
    public 으로 선언 (getter 메소드 자동 생성)
     -> 다른 컨트랙트들이 해당 배열 read only 가능, 컨트랙트에 공개 데이터 저장 시 유용
     ex) 좀비 군대를 저장하고 다른 앱에 공개하고 싶은 경우 

- **구조체 생성하고 배열에 추가하기**

    Person satoshi = Person(172, "Satoshi");
    people.push(satoshi);
    -> people.push(Person(16, "Vitalik"));

- **함수**

    function 으로 시작, 함수 인자명은 언더스코어로 시작해서 전역변수와 구별
    private 함수 만들기
    : private 은 컨트랙트 내의 다른 함수들만이 이 함수를 호출해 사용할 수 있도록 해준다. (공개 범위 설정)
    private 키워드는 함수명 다음에 적고, 함수명은 언더바로 시작

    ``` Solidity 
        /** 함수의 반환값과 함수 제어자 */

        string greeting = "What's up dog";

        function sayHello() public view returns (string) {
        return greeting;
        }
    ```

- **상태 제어자**

    1. view : 함수가 데이터를 보기만 하고 변경 x
    2. pure : 함수가 앱에서 어떤 데이터도 접근 x ex) 연산 값 돌려주는 함수

- **Keccak256**

    : 이더리움은 sha3의 한 버전인 keccak256 을 내장 해시 함수로 가짐
    입력 스트링을 랜덤 256비트 16진수로 매핑

- **형변환**

    uint8 c = a * uint8(b); 

- **이벤트**

    : 앱 사용자 단에서 어떤 액션이 발생했을 때, 컨트랙트가 블록체인 상에서 의사소통하는 방법

    ```Solidity
        event IntegersAdded(uint x, uint y, uint result); // 이벤트 선언

        function add(uint _x, uint _y) public {
            uint result = _x + _y;
            
            // 이벤트 실행 -> 앱에게 add 함수가 실행되었음을 알림:
            IntegersAdded(_x, _y, result);
            return result;
        }

        ...

        YourContract.IntegersAdded(function(error, result) {
        // 결과와 관련된 행동을 취한다
        })
    ```
</div>
</details>

<details>
<summary>Lesson2 Sum-Up</summary>
<div markdown="2">     

- **주소**

    이더리움 블록체인은 "계정"으로 이루어져 있고, 계정은 "이더(ether)"의 잔액을 가짐
    각 계정은 식별자인 주소를 가지고 있음

- **매핑**

    : 키 - 값 (키 => 값) 저장소, 데이터 저장 및 검색에 이용
    ```Solidity
        // 금융 앱용으로, 유저의 계좌 잔액을 보유하는 uint를 저장한다: 
        mapping (address => uint) public accountBalance;
        // 혹은 userID로 유저 이름을 저장/검색하는 데 매핑을 쓸 수도 있다 
        mapping (uint => string) userIdToName;
    ```

- **msg.sender**

    : 현재 함수를 호출한 사람(혹은 스마트 컨트랙트)의 주소를 가리킴, 모든 함수에서 이용 가능한 전역 변수
    
    이더리움 블록체인의 보안성과 관련 - 다른 사람의 데이터를 변결하기 위해서는 해당 이더리움 주소와 관련된 개인키를 훔치는 것 외에 방법이 없음

    ```Solidity
        zombieToOwner[id] = msg.sender; // id에 대해 msg.sender 저장
        ownerZombieCount[msg.sender]++;
    ```

- **require**

    require을 활용하면 특정 조건이 False일 때 함수가 에러 메시지를 발생시키고 실행 중지

    ```Solidity
    // sayHiToVitalik("Vitalik") 로 실행 시 "Hi!" 리턴 / 그 외 값을 인자로 넣어 실행하면 실행 x
        require(keccak256(_name) == keccak256("Vitalik")); 
    ```

- **상속**

    ```Solidity
    contract BabyDoge is Doge { } // BabyDoge 가 Doge 를 상속받음
    ```

- **Storage vs Memory**

    대부분 솔리디티가 자동 처리해주지만, 구조체/배열을 처리할 때는 필수로 사용하기 !!
    1. Storage : 블록체인 상에서 영구적으로 저장되는 변수 (like 하드디스크)
    2. Memory : 임시 저장되는 변수 - 컨트랙트 함수에 대한 외부 호출들이 일어나는 사이에 지워진다. (like RAM)

- **함수 접근 제어자 ++**

    1. public
    2. private
    3. internal : 함수가 정의된 컨트랙트를 상속하는 컨트랙트에서도 접근이 가능 (자바에서 protected와 비슷)
    4. external : 함수가 컨트랙트 밖에서만 호출될 수 있고 컨트랙트 내의 다른 함수에 의해 호출될 수 없다 !! - 왜 필요한지는 나중에..

- **인터페이스**

    블록체인 상에 있으면서 본인이 소유하지 않은 컨트랙트와 상호작용하기 위해 정의
    
    컨트랙트 정의와 비슷하지만, *다른 컨트랙트와 상호작용하기 위해 사용되는 함수*만을 선언할 뿐 다른 함수나 상태변수 언급 x (뼈대 느낌)

    ```Solidity
    contract NumberInterface {
      function getNum(address _myAddress) public view returns (uint);
    }
    ```
    
- **다수의 반환값 처리**

    ```Solidity
    function multipleReturns() internal returns(uint a, uint b, uint c) {
      return (1, 2, 3);
    }

    function processMultipleReturns() external {
      uint a;
      uint b;
      uint c;
      // 다음과 같이 다수 값을 할당한다:
      (a, b, c) = multipleReturns();
    }

    // 혹은 단 하나의 값에만 관심이 있을 경우: 
    function getLastReturnValue() external {
      uint c;
      // 다른 필드는 빈칸으로 놓기만 하면 된다: 
      (,,c) = multipleReturns();
    }
    ```

</div>
</details>

<details>
<summary>Lesson3 Sum-Up</summary>
<div markdown="3">  

- **이더리움 DApp 의 특징**
     
     1. 불변성
     
     이더리움에 컨트랙트를 배포하고 나면 컨트랙트는 변하지 않고 수정이 불가 = 컨트랙트로 배포한 최초의 코드가 항상 블록체인에 영구 존재 
     
     -> 보안 이슈 : 코드에 결점이 있다면 이후에 고칠 방법이 없다.. / 그러나 검증을 했다면, 누구도 배포 이후에 예상치 못한 결과를 발생시키지 못한다.

     2. 외부 의존성

     블록체인 외부 데이터(예를 들면 크립토키티 컨트랙트)에 버그가 생기면 본인의 DApp까지 작동하지 못할 수 있고 수정이 불가능하게 된다. 따라서 본인 댑의 중요한 일부를 수정할 수 있도록 가변 데이터/함수를 사용한다. 
     
- **Ownable 컨트랙트**

    ```Solidity
    /**
    * @title Ownable
    * @dev The Ownable contract has an owner address, and provides basic authorization control
    * functions, this simplifies the implementation of "user permissions".
    */
    contract Ownable {
      address public owner;
      event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
    * @dev The Ownable constructor sets the original `owner` of the contract to the sender
    * account.
    */
    function Ownable() public {
        owner = msg.sender;
    }

    /**
    * @dev Throws if called by any account other than the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner The address to transfer ownership to.
    */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
    }
    ```

     -> **onlyOwner()** 에 대해 더 살펴보자 !! <-
    
    ```Solidity
    function likeABoss() external onlyOwner {
        LaughManiacally("Muahahahaha");
    }
    ```

    위 코드의 예시에서, likeABoss() 함수 호출 시 사용자 정의 제어자인 onlyOwner 이 먼저 실행 -> onlyOwner 의 _; 부분에서 likeABoss 함수로 돌아와 코드 실행

    제어자 사용하는 방법들 중 require 체크를 넣는 것이 일반적이다.

    참고 : 소유자가 컨트랙트에 특별 권한을 갖도록 하는 것은 자주 필요하지만, 백도어 함수가 추가될 수도 있고 여러 방식으로 권한 관련 악용될 수 있다 !!

- **가스**

    : 이더리움 DApp이 사용하는 연료로, 솔리디티에서는 사용자들이 다른 사람의 DApp 함수를 실행할 때마다 "가스"를 지불해야 함. 사용자는 이더(ETH) 로 가스를 사기 때문에 다른 사용자의 함수를 실행하기 위해서는 ETH 소모 필요

    가스 비용은 그 연산을 수행하는 데에 소모되는 컴퓨팅 자원의 양이 결정하며, 함수 로직의 복잡성에 따라 다르다.

    왜 !! 필요한가 ??
    
        -> 이더리움은 안전하지만 크고 느리다. 누군가 무한 반복문을 써서 네트워크를 방해하거나 자원소모가 큰 연산을 씀으로써 자원 낭비를 하지 않도록 만드는 것이 이더리움의 철학이었기 때문에 가스가 필요한 것 !!

    **가스 사용 최적화**
    1. 구조체 압축 
    
        : uint는 기본 256이므로 가능하다면 uint32 등으로 축소하자

    2. view 사용 (중요)

        : view 함수는 *외부에서 호출되었을 때* (동일 컨트랙트 내의 다른 함수 내부 호출은 해당 x) 가스를 전혀 소모하지 않음. 블록체인 상에서 실제로 어떤 것도 수정하지 않기 때문 !! 

    3. storage 점검

        : storage는 영구 기록용이기 땨문에 비쌈. 진짜 필요한 경우가 아니면 memory로 변경하는 방법을 고려하자 !!

        참고 : 메모리에 배열 선언하기 / 메모리 배열은 *반드시 길이 인수와 함께 생성되어야 함*

        `uint[] memory values = new uint[](3);`


- **시간단위**

    now는 현재의 유닉스 타임스탬프 값을 반환

    ```Solidity
    uint lastUpdated;

    // `lastUpdated`를 `now`로 설정
    function updateTimestamp() public {
    lastUpdated = now;
    }

    // `updateTimestamp`가 호출된 뒤 5분이 지났으면 `true`를, 5분이 아직 지나지 않았으면 `false`를 반환
    function fiveMinutesHavePassed() public view returns (bool) {
    return (now >= (lastUpdated + 5 minutes));
    }
    ```
- **인수를 가지는 함수 제어자**
    
    ```Solidity
    // 사용자의 나이를 저장하기 위한 매핑
    mapping (uint => uint) public age;

    // 사용자가 특정 나이 이상인지 확인하는 제어자
    modifier olderThan(uint _age, uint _userId) {
      require (age[_userId] >= _age);
      _;
    }

    // `olderThan` 제어자를 인수와 함께 호출:
    function driveCar(uint _userId) public olderThan(16, _userId) {
      // 필요한 함수 내용들
    }
    ```

</div>
</details>

<details>
<summary>Lesson4 Sum-Up</summary>
<div markdown="4">  

- **payable 제어자**

    이더리움에서는 돈(_이더_), 데이터(transaction payload), 그리고 컨트랙트 코드 자체 모두 이더리움 위에 존재하기 때문에 함수를 실행하는 동시에 컨트랙트에 돈을 지불하는 것이 가능

    ```Solidity
    contract OnlineStore {
    function buySomething() external payable {
        // 함수 실행에 0.001이더가 보내졌는지 확실히 하기 위해 확인:
        require(msg.value == 0.001 ether);
        // 보내졌다면, 함수를 호출한 자에게 디지털 아이템을 전달하기 위한 내용 구성:
        transferThing(msg.sender);
    }
    }
    ```

- **출금**

    컨트랙트로 이더를 보내면 이더리움 계좌에 이더가 저장되고 갇힘 -> 컨트랙트로부터 이더를 인출하는 함수 필요

    ```Solidity
    contract GetPaid is Ownable {
        function withdraw() external onlyOwner {
            owner.transfer(this.balance);
        }
    }
    ```

    **transfer** 함수 사용
    
    : 이더를 특정 주소로 전달할 수 있게 함. 위 예시에서 this.balance는 컨트랙트에 저장되어 있는 전체 잔액을 반환한다.

    ```Solidity
    uint itemFee = 0.001 ether;
    msg.sender.transfer(msg.value - itemFee);
    ```
    (누군가 한 아이템에 대해 초과 지불을 했을 때, 이더를 msg.sender로 되돌려주는 예시)

- **난수 생성** (솔리디티에서는 안전한 난수 생성이 어렵다)

    - keccak256 해시 함수 사용

    ```Solidity
    // Generate a random number between 1 and 100:
    uint randNonce = 0;
    uint random = uint(keccak256(now, msg.sender, randNonce)) % 100; // %100은 마지막 두자리만 취하기 위함
    randNonce++;
    uint random2 = uint(keccak256(now, msg.sender, randNonce)) % 100;
    ```

</div>
</details>