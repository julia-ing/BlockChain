pragma solidity ^0.8.0;

import "./ZombieAttack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {
    
    mapping (uint => address) zombieApprovals;
    
    function balanceOf(address _owner) public view returns (uint256 _balance) {
    // `_owner`가 가진 좀비의 수 반환
        return ownerZombieCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        // `_tokenId`의 소유자 반환
        return zombieToOwner[_tokenId];
    }

    // transfer 과 approve 두 함수에서 모두 쓸 수 있도록 코드 추상화
    function _transfer(address _from, address _to, uint256 _tokenId) private {
        // ownerZombieCount[_to]++;
        // ownerZombieCount[_from]--;
        // 오버플로우 방지를 위해 SafeMath 사용 코드로 변경
        ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].sub(1);
        zombieToOwner[_tokenId] = _to;
        Transfer(_from, _to, _tokenId);
    }

    // 다른 사람에게 토큰을 주는 것에 대해 토큰 소유자만 승인할 수 있도록 제어자 onlyOwnerOf 사용 
    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        zombieApprovals[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }

    // msg.sender가 토큰/좀비를 가질 수 있도록 승인되었는지 확인하고, 승인이 되었다면 _transfer를 호출
    function takeOwnership(uint256 _tokenId) public {
        require(zombieApprovals[_tokenId] == msg.sender);
        address owner = ownerOf(_tokenId);
        _transfer(owner, msg.sender, _tokenId);
    }
}