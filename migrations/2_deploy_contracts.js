var SMToken = artifacts.require("./SMToken.sol"); //Reading the smart contract SMToken and storing it in a variable SMToken
var SMTokensale = artifacts.require("./SMTokensale.sol");

module.exports = function(deployer) {
  deployer.deploy(SMToken,1000000).then(function(){
  	var tokenPrice = 1000000000000000;//Token Price is 0.001 Ether
  	return deployer.deploy(SMTokensale,SMToken.address,tokenPrice);		
  }); //Deplot the SMToken.sol using SMToken || 1000000 will be passed to the constructor 
  
};
