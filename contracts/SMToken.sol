pragma solidity >=0.4.21 <0.6.0;

contract SMToken {
	string public name = "SM Token";
	string public symbol = "SM";
	string public standard = "SM Token v1.0";
	uint256 public totalSupply; //Declare the global variable totalsupply in the blockchain.

	//All of the functions in ERC20 standard must fire a transfer event,The function should throw if the _from 	account balance doesnot have enough tokens to spend.
	// Transfer event
	event Transfer(
			address indexed _from,
			address indexed _to,
			uint256 _value
	);
	event Approval(
		address indexed _owner,
		address indexed _spender,
		uint256 _value 
	);

	mapping(address => uint256) public balanceOf; //  we minted the 1M token but where ? this is the address where we minted the totalSupply.
	mapping(address => mapping(address => uint256)) public allowance;

	constructor (uint256 _initialSupply) public {
		balanceOf[msg.sender] = _initialSupply;//msg is a global variable in solidity that has several values you can read from it , in this case sender is the
											   //address that called this function.so this means that our first account in ganache will have the total supply.	
		totalSupply = _initialSupply ;//Total Supply of the our tokens
	}
	//Transfer
	function transfer(address _to , uint256 _value) public returns (bool success){
		//Exception if account doesnt have enough
		require(balanceOf[msg.sender] >= _value); //require means if the condition in it is wrong stop executing the function
		//Transfer the balance
		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		//Transfer Event
		emit Transfer(msg.sender,_to,_value);
		
		//Return a boolean value
		return true;
	}
	//approve
	function approve(address _spender, uint256 _value) public returns (bool success){
		//allowance
		allowance[msg.sender][_spender] = _value;

		//Approval event
		emit Approval(msg.sender,_spender,_value);
		return true;
	}
	//transfer from 
	function transferFrom(address _from, address _to , uint256 _value) public returns (bool success) {
		
		require(_value <= balanceOf[_from]);		
		//Required allowance is big enough
		require(_value <= allowance[_from][msg.sender]);
		//change the balance
		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
		//update the allowance
		allowance[_from][msg.sender] -= _value;
		//transfer event
		emit Transfer(_from,_to,_value); 
		//return a boolean
		return true;

	}
}	