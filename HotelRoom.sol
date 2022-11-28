// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract HotelRoom {
        enum Statuses {
        Vacant, 
        Occupied
        }
        Statuses public currentStatus;

        address payable public Owner;

        event Occupy(address _occupent, uint _value);


        constructor() {
            Owner = payable(msg.sender);
            currentStatus = Statuses.Vacant;
        }

        modifier onlyWhileVacant {
            require(currentStatus == Statuses.Vacant, "Currently Occupied");
            _;
        }
        modifier costs(uint _amount) {
            require(msg.value >= _amount, "Not Enough Ethers Provided");
            _;
        }
        //
        function book() payable public onlyWhileVacant costs(2 ether) {
            
            currentStatus = Statuses.Occupied;

            Owner.transfer(msg.value);

            (bool sent, bytes memory data) = Owner.call{value: msg.value}("");

            require(true);

            emit Occupy(msg.sender, msg.value);
        }
}
