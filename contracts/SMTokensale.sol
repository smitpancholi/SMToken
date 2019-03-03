pragma solidity >=0.4.21 <0.6.0;
import "./SMToken.sol";

contract SMTokensale{
	address admin;//We have not declared admin as public because we dont want this address to be exposed.
	SMToken public tokenContract;//SMToken is a datatype of the type of our SMToken.sol contract
	//so tokenContract is of the type SMToken
	uint256 public tokenPrice; // As we have written public we will get the function names tokenPrice() for free. we dont need to write it.which will return the value to tokenPrice whenever we ask for it in the test
	uint256 public tokensSold;

	event Sell(address _buyer , uint256 _amount);

	constructor(SMToken _tokenContract , uint256 _tokenPrice) public {
		//Assign an admin , which will have special priviledges , for eg admin can end the token sale.
		admin = msg.sender; // admin is the person who deployed the contract.
		//Token Contract - because we want to actually purchase tokens
		tokenContract = _tokenContract;
		tokenPrice = _tokenPrice;
	}
	function multiply(uint x, uint y) internal pure returns (uint z) {//internal means it can ony be called internally not externally and pure means no transactions will be updated
        require(y == 0 || (z = x * y) / y == x);
    }
	function buyTokens(uint256 _numberOfTokens) public payable{//payable means we can use ether to buy tokens
		//Require that the value is equal to tokens
		require (msg.value == multiply(_numberOfTokens,tokenPrice));
		//Require that the contract has enough tokens
		require (tokenContract.balanceOf(address(this)) >= _numberOfTokens);
		//Require that the transfer is successfull.
		require (tokenContract.transfer(msg.sender,_numberOfTokens));
		
		//Keep track of the tokens sold
		tokensSold += _numberOfTokens;
		//trigger sell event 
		emit Sell(msg.sender , _numberOfTokens);
	}
}
