//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

enum Status{ pending, Ordered, Shipping, OnDelivery, OnPause, Delivered, Cancelled}

struct Company{
  address owner;
  string companyName;
  string location;
  uint256 asset;
 }

struct Product{
   Company company;
   string Name;
   string RegNum;
   uint256 price;
   uint256 Manufacture_date;
   uint256 Expired_date;
   bool Availabilty;
}
struct Order{
  Company company;
  address customer;
  Product product;
  uint256 UnitPrice;
  string Location;
  uint256 date;
  Status status;
  uint256 D_date;
}

struct escrowInfo{
    address buyer;
    uint256 amount;
    bool released;
}

