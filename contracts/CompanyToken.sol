//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/Token/ERC20/ERC20.sol";
import "openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
  uint256 public constant Exchange_Rate = 100;//100 Gwei per token
  uint256 public gweToWei = 1e9;// 1 Gwe = 10^9 wei


  constructor() ERC20("J_Token", "JTK") Ownable(msg.sender){
     _mint(msg.sender, 100000*10**18);
  }

   event mintToken(address indexed _to, uint256 value);


  receive() external payable {
    buyTokens();
  }

  //minting function
  function MintToken(address _to, uint256 _amount) public Onlyowner {
    require(_amount >= 100, "Amount has to be at least 100");
    _mint(_to, _amount);

    event mintToken(_to, _amount);
  }

  function buyToken() public payable {
   uint256 tokensToBuy= (msg.value/gweToWei/100);
   require(tokensToBuy > 0, "You must sent some ether");

   // IntiAlize a DexBalance variable to check the wallet balance.
    uint256 DexBalance = balanceOf(address(this));
    require(tokensToBuy <= DexBalance, "Not enough tokens in the reserve");

   // execute transfer
    _transfer(address(this), msg.sender, tokensToBuy);
  }

  function withdraw() public onlyOwner {
    (bool sent, bytes memory data) = payable(owner()).call{value:msg.value}("");
    require(msg.value <= address(this).balance);
    require(sent, "Transfer failed");
  }

  function depositTokens(uint256 amount) public onlyOwner{
    _transfer(msg.sender, address(this), amount);
  }

  function transfer(address recipient,unit amount) public Onlyowner (bool){
    require(owner => amount, "insufficient balance");
    require(recipient != owner, "You can't transfer token to yourself");
    require(amount > 0, "input a value");
      recipient.transfer(amount);
    receiver = recipient;
    owner -= amount;
    receiver += amount
    return true;
  }
  function transferFrom(address From, address to, uint256 amount) public {
    require(From != to, "You can transfer to the same account");
  }

}
