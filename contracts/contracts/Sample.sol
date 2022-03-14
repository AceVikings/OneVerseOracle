//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./PriceSigner.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Sample is PriceSigner,Ownable{

    address backendSigner;

    event priceEvent(uint price);

    function PriceImplementation(Price memory priceInfo) external {
        require(getSigner(priceInfo) == backendSigner,"Invalid signer");
        require(block.timestamp - priceInfo.time < 2 minutes,"signature expired");
        emit priceEvent(priceInfo.price);
    }

    function setSigner(address _address) external onlyOwner{
        backendSigner = _address;
    }

}