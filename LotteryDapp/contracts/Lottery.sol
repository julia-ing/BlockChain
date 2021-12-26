pragma solidity >= 0.4.21;

contract Lottery {
    address public owner; // public으로 만들면 getter 자동 생성

    constructor() public { // 생성자
        owner = msg.sender; 
    }

    function getSomeValue() public pure returns (uint256 value) {
        return 5;
    }
}