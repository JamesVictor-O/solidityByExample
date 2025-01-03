// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Hostel{

    address payable manager;
    // uint public availableRooms=0;


    constructor(){
        manager= payable (msg.sender);
    }

    // Room struct
    struct Room{
        uint id;
        uint roomPrice;
        bool isAvailable;
        uint roomCapacity;
    }

    mapping (uint => Room ) public rooms;
    uint[] public roomIds;
    
    // Booking struct

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
        require(msg.sender != manager, "You can't Book a room as an owner");
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
         roomIds.push(_i);
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

    // function for booking cancelation

    function cancelBooking(uint _roomId) public notOwners{

        Booking storage  booking = bookings[_roomId];
        //  checking if the room was booked and the msg.sender was the one who booked it
        require(booking.isConfiremd, "Booking does not exist or is already canceled");
        require(msg.sender == booking.customer, "Only the customer can cancel this booking");
      
        // amount to be refunded
        uint refundAmount = booking.amountPaid;
          
        //    checking if the contract has the amount to be refunded
          require(address(this).balance >= refundAmount  ,"Insufficient Amount in contract balance");


            // tranfering funds to owner
          (bool success,)=msg.sender.call{value: refundAmount}("");

          require(success, "Trasfer failed");
        //    deleting the booking from the booking mapping
          delete bookings[_roomId];

        // updating the room status
          rooms[_roomId].isAvailable=true;

    }
    
   
   // deposit function   
    function deposit() public payable {
       require(msg.value > 0, "value must be greater than 0");
       balances[msg.sender] += msg.value;
    }


    // function for checking available rooms 

    function availableRooms() public view returns (Room[] memory){
         uint count = 0;

         for(uint i=0; i < roomIds.length; i++){
            if(rooms[roomIds[i]].isAvailable){
                count ++;
            }
         }


        Room[] memory roomsAvailable = new Room[](count);
        uint index=0;

           for (uint i = 0; i < roomIds.length; i++) {
            if (rooms[roomIds[i]].isAvailable) {
                 roomsAvailable[index] = rooms[roomIds[i]];
                index++;
            }
         }

        return  roomsAvailable;

    }

    event Received (address sender, uint amount);

    receive() external payable { 
        emit Received(msg.sender, msg.value);
    }
    
    // withdrawal function
   function withdraw(uint _amount) public onlyOwner{
      (bool success,)= msg.sender.call{value: _amount}("");
       
      require(success, "Transfer Faild");
   }
}