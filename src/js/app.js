App = {
  web3Provider: null,
  contracts: {},
  account: '0x0',

  init : function() {
    console.log("App Initialized...");
    return App.initWeb3();
  },

  initWeb3: function() { //Wire up metamask to web3
    if (typeof web3 !== 'undefined') {
      // If a web3 instance is already provided by Meta Mask.
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // Specify default instance if no web3 instance provided
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      web3 = new Web3(App.web3Provider);
    }
    return App.initContracts();
  },

  initContracts: function() {
    $.getJSON("SMTokenSale.json", function(smTokenSale) {
      App.contracts.SMTokenSale = TruffleContract(smTokenSale);
      App.contracts.SMTokenSale.setProvider(App.web3Provider);
      App.contracts.SMTokenSale.deployed().then(function(smTokenSale) {
        console.log("SM Token Sale Address:", smTokenSale.address);
      });
    }).done(function() {
      $.getJSON("SMToken.json", function(smToken) {
        App.contracts.SMToken = TruffleContract(smToken);
        App.contracts.SMToken.setProvider(App.web3Provider);
        App.contracts.SMToken.deployed().then(function(smToken) {
          console.log("SM Token Address:", smToken.address);
        });

        //App.listenForEvents();
        return App.render();
      });
    })
  },
  render : function(){
    //Load account data
    web3.eth.getCoinbase(function(err, account) {//getCoinBase() gives your currently logged in account adddress in metamask
      if(err === null) {
        App.account = account;
        $('#accountAddress').html("Your Account: " + account);
      }
    })
  }
}

$(function(){
  $(window).load(function(){
    App.init();
  })
})