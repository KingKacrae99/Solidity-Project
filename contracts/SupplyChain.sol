//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;


import "./Supplystruct.sol";
import "./CompanyToken.sol";
import "./Escrow.sol";

contract SupplyChain is Token, Escrow {

   // state variable for counting order.
   uint256 public orderCount;
   // state variable for counting product.
   uint256 public productCount;
   // state variable for shipping fees
   uint256 public shipmentFee = 3000; // 3000wei


   // tracking stored product and order.
   mapping(uint256 => Product) public products;
   mapping(uint256 => Order) public orders;

   //event
   event orderEvent(uint256 orderId, address indexed customer, Status status);
   event productCreatedEvent(uint256 productId, string name, string regNum);
   event OnDelivery(uint256 orderId, address indexed customer);
   event ProductPurchase(uint256 orderId, string productname, address indexed customer);
   event UpdateOrder(uint256 orderId, Status status,uint256 Delivery_day);
   event CancelOrder(uint256 orderId, address indexed customer, Status status);

   constructor(){
    owner = msg.sender;
   }

   modifier Onlyowner(){
    require(msg.sender == owner, "You are not authorized to access this");
    _;
   }

   function CreateProduct(string memory name, string memory regnum,
          uint256 _price,uint256 man_date,uint256 ex_date)
          public {
      require(man_date > 0, "pls indicate the manufacture date");
      require(ex_date > 1, "your date of expiration must be from 2 day above");
      require(_price > 0, "You haven't set a value for your product");

      productCount++;
      products[productCount] = Product(company(msg.sender, "MarketSquare", "Jabi,Abuja"
       balanceOf(msg.sender)), name, regnum, _price, man_date, ex_date, true);

      emit productCreatedEvent(productCount, name, regnum);
   }

   function CreateOrder(address _customer,uint256 _productId, uint256 _UnitPrice, string memory location)
         public returns(string memory) {
     require(location != "", "pls, input a location for delivery");
     require(_productId <= productCount, "invalid productId");
     require(_UnitPrice == products[productCount].price, "amount not up to the product value");
     require(!products[productCount].Availabilty, "product not available");
     orderCount++;
     orders[orderCount] = (Order(products[_productId].company,_customer,products[productId],
     products[_productId].price,block.timestamp, Status.pending, 0);

     depositEscrow(_propertyId,msg.sender, msg.value);
     orders[orderCount].status= Status.Ordered;

     emit orderEvent(orderCount, _customer, Status.pending);
     return "Successfully";
   }

   function updateOrder(
         uint256 orderId,
         Status _status,
         uint256 _Dday
   ) public Onlyowner{
      require(orderId <= orderCount, "invalid orderId");
      require(_Dday != orders[orderId].date, "delivery time is same as the orderd time");

      uint256 convertTime = _Dday * 86400;
      orders[orderId].D_date = order[orderId].date + convertTime;
      orders[orderId].status = _status;

      emit UpdateOrder(orderId, _status, _Dday);
   }

   // function to cancel Shipment
   function cancelParcel(uint256 orderId) public returns(string memory){
      require(orderId >= 0 && orderId <=orderCount, "this shipment does not exist");
      require(msg.sender == orders[orderId].customer, "you can't cancel the parcel");
      require(order[orderId].status != Status. Delivered, "shipment has ready be delivered");
      orders[orderId].status = Status.cancelled;

      require(orders[orderId].status == Status.cancelled, "order has been already been cancelled by you");
      address payable revertTo = payable(orders[orderId].customer;
      ReleasedEscrow(_orderId, reverTo);

       emit CancelOrder(orderId, orders[orderId].customer, orders[orderId].status);
      return shipment has been cancelled
   }

   //confirm delivery
   function AcceptDelivery(uint256 _orderId) public {
     require (_orderId <= orderCount, "this order does not exist");
     require(msg.sender == orders[_orderId].customer, "not the owner of the delivery");

      address payable seller = payable(owner);

      // calling the Released function in Escrow
     ReleasedEscrow(_orderId, seller);
     orders[_orderId].status = Status.Delivered;

     emit orderEvent(_orderId, orders[_orderId].customer, orders[_orderId].status);
   }

   function viewHistory(uint256 productId) public view returns(string[] memory){
       require(productId >= 0 && productId <= productCount, "Product does not exist");
       uint256 count = 0;
       for (uint256 i = 1; i <= orderCount; i++) {
           if (orders[i].productId == productId) {
             count++;
           }
       }
       Order[] memory history = new Transfer[](count);
       uint256 index = 0;
       for (uint256 i = 1; i <= orderCount; i++){
           if (orders[i].productId == productId) {
             index++;
           }

       }
    return history;
   }

}


