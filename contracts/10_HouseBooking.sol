// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Hostel{

    address payable manager;
    uint public availableRooms=0;


    constructor(){
        manager= payable (msg.sender);
    }

    // Room
    struct Room{
        uint id;
        uint roomPrice;
        bool isAvailable;
        uint roomCapacity;
    }

    mapping (uint => Room ) public rooms;
    
    // Booking

    struct Booking{
        address customer;
        uint roomId;
        uint amountPaid;
        bool isConfiremd;
        uint checkoutTime;
        uint checkInTime;
    }
    
    mapping (uint => Booking) public bookings;
    mapping (address => uint) public balances;

    // only owner can add rooms
    modifier  onlyOwner(){
        require(msg.sender == manager, "Not the manager");
        _;
    }
    // only customers

    modifier  notOwners(){
        require(msg.sender != manager, "Not owners");
        _;
    }
    // book only if room is available
    modifier roomAvailable(uint _roomId){
        require(rooms[_roomId].isAvailable == true,"Room not available");
        _;
    }

    // function for adding rooms for manager/owner
    function addRoom(uint _i, uint _roomPrice,uint _roomCapacity) public onlyOwner{
         rooms[_i]=Room(_i,_roomPrice,false,_roomCapacity);
    }

    // function to remove rooms 
    function removeRoom(uint _i) public onlyOwner{
        delete rooms[_i];
    }

    // owner should be able to update status of room availability
    function updateRooms(uint _key, uint _newPrice, bool _isAvailable ) public  onlyOwner{
        rooms[_key].roomPrice=_newPrice;
        rooms[_key].isAvailable=_isAvailable;
    }

    // function for booking room
   
    function bookRoom(uint _roomId, uint _stayDuration ) public payable notOwners roomAvailable(_roomId) {
          require(msg.value >= rooms[_roomId].roomPrice,"Insuficient ethers");

        // change room avalibilty to false
          rooms[_roomId].isAvailable=false;
           
        //    check in time 
          uint checkInTime=block.timestamp;

        //   checkout time
          uint checkOutTime=checkInTime + _stayDuration * 1 days;

          bookings[_roomId] = Booking({
                customer:msg.sender,
                roomId:_roomId,
                amountPaid:msg.value,
                isConfiremd:true,
                checkoutTime: checkOutTime,
                checkInTime: checkInTime
          });

    }

   // deposit function   
    function deposit() public payable {
       require(msg.value > 0, "value must be greater than 0");
       balances[msg.sender] += msg.value;
    }

    receive() external payable { }
    // function withdrawFunds() public payable  onlyOwner{

    // }
}