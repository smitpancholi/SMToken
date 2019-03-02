pragma solidity >=0.4.21 <0.6.0;
import "./SMToken.sol";

contract SMTokensale{
	address admin;//We have not declared admin as public because we dont want this address to be exposed.
	SMToken public tokenContract;//SMToken is a datatype of the type of our SMToken.sol contract
	//so tokenContract is of the type SMToken
	uint256 public tokenPrice; // As we have written public we will get the function names tokenPrice() for free. we dont need to write it.

	constructor(SMToken _tokenContract , uint256 _tokenPrice) public {
		//Assign an admin , which will have special priviledges , for eg admin can end the token sale.
		admin = msg.sender; // admin is the person who deployed the contract.
		//Token Contract - because we want to actually purchase tokens
		tokenContract = _tokenContract;
		tokenPrice = _tokenPrice;


		//Token Price

	}
}
