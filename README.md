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

<details>
<summary>Lesson5 Sum-Up</summary>
<div markdown="5">  

- **토큰**

    이더리움에서 토큰은 몇몇 공통 규약을 따르는 스마트 컨트랙트. 즉 다른 모든 토큰 컨트랙트가 사용하는 표준 함수 집합을 구현하는 것. 

    ex) 
    
    `transfer(address _to, uint256 _value)`

    `balanceOf(address _owner)`

    기본적으로 토큰은 그저 하나의 컨트랙트이다. 그 안에서 누가 얼마나 많은 토큰을 갖고 있는지 기록하고 함수를 이용해 사용자들이 토큰을 다른 주소로 전송할 수 있게 해준다 !!

    WHY 이렇게 할까 ??
    
    -> 모든 ERC20 토큰들이 똑같은 이름의 동일한 함수 집합을 공유하기 때문에 이 토큰들에 똑같은 방식으로 상호작용이 가능 : 만약 본인이 ERC20 토큰과 상호작용할 수 있는 앱을 하나 만든다면, 새로운 토큰의 컨트랙트 주소를 끼워넣는 것만으로 다른 어떤 ERC20 토큰과도 상호작용이 가능하다 !! 

    ex) 거래소 - 새로운 ERC20 토큰을 상장할 때, 실제로는 이 거래소에서 통신이 가능한 또 하나의 스마트 컨트랙트를 추가하는 것이다. 사용자들은 이 컨트랙트에 거래소의 지갑 주소에 토큰을 보내라고 할 수 있고 / 거래소에서는 이 컨트랙트에 사용자들이 출금을 신청하면 토큰을 다시 돌려보내라고 할 수 있다.

    - 토큰의 종류
    
        ERC20 - 위처럼 화폐처럼 사용되는 토큰에 적합

        ERC721 - 교체 불가. 분할이 불가하기 때문에 전체 단위로만 거래할 수 있고 각각의 토큰은 유일한 ID를 갖는다. ex) 크립토좀비, 크립토 수집품
        
        ERC721 표준은 아래와 같다.

        ```Solidity
        contract ERC721 {
        event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
        event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

        // balanceOf : address를 받아 해당 address가 토큰을 얼마나 가지고 있는지 반환
        function balanceOf(address _owner) public view returns (uint256 _balance);
        // ownerOf : 토큰 ID(좀비 ID)를 받아 이를 소유하고 있는 사람의 address를 반환
        function ownerOf(uint256 _tokenId) public view returns (address _owner);

        // 토큰 전송의 두가지 방법

        /// 1. 토큰 소유자가 transfer 호출 (takeOwnership과 동일한 로직, 순서만 반대 - 전자는 토큰을 보내는 사람이 함수 호출, 후자는 받는 사람이 호출)

        /// 2. 토큰 소유자가 approve 호출 
        ///    -> 이후에 mapping(uint256 => address) 를 사용해 컨트랙트에 누가 해당 토큰을 가질 수 있도록 허가받았는지 저장
        ///    -> 누군가 takeOwnership 호출하면 해당 컨트랙트는 이 msg.sender가 소유자로부터 토큰을 받을 수 있게 허가받았는지 확인하고 전송

        function transfer(address _to, uint256 _tokenId) public;
        function approve(address _to, uint256 _tokenId) public;
        function takeOwnership(uint256 _tokenId) public;
        }
        ```

- **컨트랙트 보안 강화 : 오버플로우와 언더플로우**
    
    ```Solidity
    uint8 number = 255;
    number++; // 256이 아닌 0이 됨 -> 오버플로우
    // 언더플로우는 이와 유사하게 0 값을 가진 uint8에서 1을 빼면 255와 같아지는 것
    ```

    -> **SafeMath** 라이브러리 사용하기 !!

    `using SafeMath for uint256;`

    ```Solidity
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
    ```

    assert 구문으로 합한 결과가 더 큼을 보장함으로써 오버플로우를 막아준다. 

    assert는 조건을 만족하지 않으면 에러를 발생시킨다는 점에서 require와 비슷하다. 그러나 assert와 require의 차이점은, require은 함수 실행이 실패하면 남은 가스를 사용자에게 되돌려 주지만, assert는 그렇지 않다는 것 -> assert 는 오버플로우와 같이 코드가 심각하게 잘못 실행되는 경우 사용

    결과적으로 SafeMath 를 사용하기 위해서 코드는

    `myUint++; `
    
    를 아래와 같이 변경해줄 수 있다 !!
    
    `myUint = myUint.add(1);`

- **주석**

    natspec 표준 주석으로 /// 사용

</div>
</details>

<details>
<summary>Lesson6 Sum-Up</summary>
<div markdown="6">  

- **Web3.js**

    이더리움 네트워크는 노드로 구성되어 있고, 각 노드는 블록체인의 복사본을 가지고 있다. 만약 스마트 컨트랙트의 함수를 실행하고자 한다면 이 노드들 중 하나에 쿼리를 보내 아래와 같은 내용을 전달해야 한다:

    1. 스마트 컨트랙트의 주소
    2. 실행하고자 하는 함수
    3. 그 함수에 전달하고자 하는 변수들

    이더리움 노드들은 JSON-RPC라고 불리는 언어로만 소통할 수 있고 쿼리는 이런 형식이다.

    `{"jsonrpc":"2.0","method":"eth_sendTransaction","params":[{"from":"0xb60e8dd61c5d32be8058bb8eb970870f07233155","to":"0xd46e8dd67c5d32be8058bb8eb970870f07244567","gas":"0x76c0","gasPrice":"0x9184e72a000","value":"0x9184e72a","data":"0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"}],"id":1}`

    그러나 Web3.js는 이러한 복잡한 쿼리를 작성할 필요 없이 우리 코드에서 함수를 호출하면 되도록 해주는데 이는 아래와 같이 하면 된다 !!

    ```Solidity
    CryptoZombies.methods.createRandomZombie("Vitalik Nakamoto 🤔")
    .send({ from: "0xb60e8dd61c5d32be8058bb8eb970870f07233155", gas: "3000000" })
    ```

    *시작하는 방법*

    ```shell
    npm install web3
    yarn add web3
    bower install web3

    // 혹은 
    <script language="javascript" type="text/javascript" src="web3.min.js"></script>
    ```

- **Web3 프로바이더**

    프로바이더를 설정하는 것은 코드에 읽기와 쓰기를 처리하려면 어떤 노드와 통신해야 하는지 설정하는 것이다. (like 웹앱에서 api 호출을 위해 원격 웹 서버의 url을 설정하는 것)

    **Infura**

    : 빠른 읽기를 위한 캐시 계층을 포함하는 다수의 이더리움 노드를 운영하는 서비스, 접근을 위한 api를 무료로 사용할 수 있다.

    `var web3 = new Web3(new Web3.providers.WebsocketProvider("wss://mainnet.infura.io/ws"));`

    그러나 많은 사용자들이 DApp을 사용하면서 단순히 읽기만 하는 것이 아니라 블록체인에 무언가 쓰기도 할 것이므로 우리는 이 사용자들이 그들의 개인 키로 트랜잭션에 서명할 수 있도록 해야 한다 -> Metamask

    **Metamask**

    : 사용자들이 이더리움 계정과 개인 키를 안전하게 관리할 수 있게 해주는 크롬.파이어폭스 브라우저 확장 프로그램 / 해당 계정을 사용해 Web3.js 웹사이트들과 상호작용할 수 있게 해줌

    ```JavaScript
    window.addEventListener('load', function() {

    // Web3가 브라우저에 주입되었는지 확인(Mist/MetaMask)
    if (typeof web3 !== 'undefined') {
        // Mist/MetaMask의 프로바이더 사용
        web3js = new Web3(web3.currentProvider);
    } else {
        // 사용자가 Metamask를 설치하지 않은 경우에 대해 처리
        // 사용자들에게 Metamask를 설치하라는 등의 메세지를 보여줄 것
    }
    // 이제 앱을 시작하고 web3에 자유롭게 접근할 수 있다:
    startApp()
    })
    ```

- **컨트랙트와 대화하기**

    Web3.js는 스마트 컨트랙트와 통신하기 위해 두가지를 필요로 한다:

    1. 컨트랙트의 주소

        컨트랙트를 배포한 후 그 컨트랙트는 이더리움 상에서 고정된 주소를 얻을 것이다. ex) 크립토키티의 주소: 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d

    2. ABI

        : Application Binary Interface - JSON 형태로 컨트랙트의 메소드를 표현한다. 컨트랙트가 이해할 수 있도록 Web3.js가 어떤 형태로 함수 호출을 해야 하는지 알려준다.

    이 두가지를 얻고 나면 다음과 같이 Web3에서 컨트랙트를 인스턴스화할 수 있다:

    `var myContract = new web3js.eth.Contract(myABI, myContractAddress);`

- **컨트랙트 함수 호출하기**

    Web3.js는  컨트랙트의 함수를 호출하기 위한 두 개의 메소드를 가지고 있다: 
    
    1. Call

        - view와 pure 함수(읽기 전용)를 위해 사용
        - 로컬 메소드에서만 실행, 블록체인에 트랜잭션을 만들지 x

        `myContract.methods.myMethod(123).call()`

    2. Send

        - view와 pure가 아닌 모든 함수에 사용
        - 트랜잭션을 만들고 블록체인 상의 데이터를 변경 -> 가스 소모
        - 트랜잭션을 전송하려면 함수를 호출한 사람의 from 주소 필요 (msg.sender)

        `myContract.methods.myMethod(123).send()`

- **메타마스크에서 사용자 계정 가져오기

    `var userAccount = web3.eth.accounts[0]`

    사용자가 언제든 메타마스크에서 활성화된 계정을 바꿀 수 있기 때문에 우리는 이 변수 값이 바뀌었는지 확인하기 위해 계속 감시하고, 값이 바뀌면 그에 따라 UI를 업데이트 해야 한다. 이를 위해 **setInterval** 을 쓸 수 있다.

    ```js
    var accountInterval = setInterval(function() {
    // userAccount가 여전히 web3.eth.accounts[0]과 같은지 확인하기 위해 100밀리초마다 확인
    if (web3.eth.accounts[0] !== userAccount) {
        userAccount = web3.eth.accounts[0];
        // 새 계정에 대한 UI로 업데이트하기 위한 함수 호출
        updateInterface();
    }
    }, 100);
    ```

- **indexed**

    이벤트를 필터링하고 현재 사용자와 연관된 변경만을 수신하기 위해, 우리의 ERC721을 구현할 때 Transfer 이벤트에서 했던 것처럼 우리의 솔리디티 컨트랙트에 indexed 키워드를 사용한다. 

    `event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);`

    위와 같은 경우 _from과 _to가 indexed 되어있으므로 프론트의 이벤트 리스너에서 이들을 필터링해줄 수 있다.

    ```js
    // `filter`를 사용해 `_to`가 `userAccount`와 같을 때만 코드를 실행
    cryptoZombies.events.Transfer({ filter: { _to: userAccount } })
    .on("data", function(event) {
    let data = event.returnValues;
    // 해당 좀비를 보여줄 수 있게 UI를 업데이트할 수 있도록 여기에 추가
    }).on("error", console.error);
    ```

- **지난 이벤트에 대해 쿼리 날리기**

    getPastEvents 이용 !!

    ```js
    cryptoZombies.getPastEvents("NewZombie", { fromBlock: 0, toBlock: "latest" })
    .then(function(events) {
    // `events`는 우리가 위에서 했던 것처럼 반복 접근할 `event` 객체들의 배열
    });
    ```

</div>
</details>