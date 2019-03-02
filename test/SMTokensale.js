var SMTokensale = artifacts.require("./SMTokensale.sol");

contract('SMTokensale',function(accounts){
	var tokenSaleInstance;
	var tokenPrice = 1000000000000000;//in wei

	it('initializes the contract with the correct values',function(){
		return SMTokensale.deployed().then(function(instance){
			tokenSaleInstance = instance;
			return tokenSaleInstance.address;
		}).then(function(address){
			assert.notEqual(address , 0x0 , 'has contract address');//return the address of the SMTokensale.sol contract
			return tokenSaleInstance.tokenContract();
		}).then(function(address){
			assert.notEqual(address , 0x0 , 'has the token contract address');//returns the adress of the function tokenContract()
			return tokenSaleInstance.tokenPrice();
		}).then(function(price){
			assert.equal(price,tokenPrice,'token price is correct');
		});
	});
})