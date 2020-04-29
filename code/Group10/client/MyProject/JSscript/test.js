
const EthCrypto = require("eth-crypto")
window.EthCrypto = EthCrypto;

function testFunc(str){
    return str + str;
}

function createIdentity(){
    return EthCrypto.createIdentity();
}

function publicKeyByPrivateKey(privateKey){
    return EthCrypto.publicKeyByPrivateKey(privateKey);
}
