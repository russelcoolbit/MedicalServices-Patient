pragma solidity ^0.4.0;

contract Data {
  address owner;
  struct Information {
    address deviceId;
    bytes32 keyOne;
    bytes32 keyTwo;
    string subject;
    bytes32 hashedData;
    bytes32 r;
    bytes32 s;
    uint8 v;
  }
  mapping(string => Information) private info;
  function Data(){
    owner = msg.sender;
  }
  function addData(string dataId, address deviceId,bytes32 first,bytes32 second , bytes32 hashed, string desc ,bytes32 r, bytes32 s , uint8 v){
    Information a = info[dataId];
    a.deviceId = deviceId;
    a.keyOne = first;
    a.keyTwo = second;
    a.subject = desc;
    a.hashedData = hashed;
    a.r = r;
    a.s = s;
    a.v = v;
  }
  function getPublicKey(string dataId) constant returns(bytes32, bytes32) {
    return (info[dataId].keyOne, info[dataId].keyTwo);
  }
  function getSignature(string dataId) constant returns(bytes32, bytes32, uint8) {
    return (info[dataId].r, info[dataId].s, info[dataId].v);
  }
  function getOther(string dataId) constant returns(address,string,bytes32) {
    return (info[dataId].deviceId, info[dataId].subject, info[dataId].hashedData);
  }
  function kill(){
    selfdestruct(owner);
  }
}