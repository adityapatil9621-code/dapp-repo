
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Rental {

    string public agencyName = "Rental Agency";

    event VehicleRented(string, uint);

    function calculateRent(uint daysRented) public virtual {
        emit VehicleRented("Select type", 0 * daysRented);
    }
}

contract CarRental is Rental {

    function calculateRent(uint daysRented) public override {
        uint ppd = 10000;
        uint price = ppd * daysRented;

        emit VehicleRented("car", price);
    }

    function payRent(uint daysRented) public payable {
        uint ppd = 10000;
        uint price = ppd * daysRented;

        require(daysRented > 0, "Invalid rental days");
        require(msg.value == price, "Incorrect payment");
    }
}

contract BikeRental is Rental {

    function calculateRent(uint daysRented) public override {
        uint ppd = 3000;
        uint price = ppd * daysRented;

        emit VehicleRented("bike", price);
    }

    function payRent(uint daysRented) public payable {
        uint ppd = 3000;
        uint price = ppd * daysRented;

        require(daysRented > 0, "Invalid rental days");
        require(msg.value == price, "Incorrect payment");
    }
}
