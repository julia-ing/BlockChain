# BlockChain

## CryptoZombies 
<details>
<summary>Lesson1 Sum-Up</summary>
<div markdown="1">       

<span style="color:green">상태변수</span> : 
    컨트랙트 저장소에 영구적으로 저장 (이더리움 블록체인에 기록됨)

<span style="color:green">구조체</span> : 
    여러 특성을 가진, 보다 복잡한 자료형 생성

<span style="color:green">배열</span>

    1. 정적 배열 : string[5] stringArray;
    2. 동적 배열 : uint[] dynamicArray;
    구조체의 동적 배열을 생성하면 (db처럼) 컨트랙트에 구조화된 데이터를 저장하는 데 유용
    public 으로 선언 (getter 메소드 자동 생성)
     -> 다른 컨트랙트들이 해당 배열 read only 가능, 컨트랙트에 공개 데이터 저장 시 유용
     ex) 좀비 군대를 저장하고 다른 앱에 공개하고 싶은 경우 

<span style="color:green">구조체 생성하고 배열에 추가하기</span>

    Person satoshi = Person(172, "Satoshi");
    people.push(satoshi);
    -> people.push(Person(16, "Vitalik"));

<span style="color:green">함수</span>

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

<span style="color:green">제어자 </span>

    1. view : 함수가 데이터를 보기만 하고 변경 x
    2. pure : 함수가 앱에서 어떤 데이터도 접근 x ex) 연산 값 돌려주는 함수

<span style="color:green">Keccak256</span>
    : 이더리움은 sha3의 한 버전인 keccak256 을 내장 해시 함수로 가짐
    입력 스트링을 랜덤 256비트 16진수로 매핑

<span style="color:green">형변환</span>
    uint8 c = a * uint8(b); 

<span style="color:green">이벤트</span>
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


</div>
</details>