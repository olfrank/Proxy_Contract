const Dogs = artifacts.require("Dogs");
const DogsUpdated = artifacts.require("DogsUpdated");
const Proxy = artifacts.require("Proxy");

module.exports = async function(deployer, network, accounts){
    const dogs = await Dogs.new();
    const proxy = await Proxy.new(dogs.address);

    //sending our Dog request through the proxy
    var proxyDog =  await Dogs.at(proxy.address);
    await proxyDog.setNumberOfDogs(10);

    var noOfDogs = await proxyDog.getNumberOfDogs();
    console.log(noOfDogs.toNumber());

    //new version of Dogs
    const dogsupdated = await DogsUpdated.new();
    proxy.upgrade(dogsupdated.address);
    // fool truffle, now thinks proxyDog has all functions
    proxyDog =  await DogsUpdated.at(proxy.address);
    //initialise the proxy so that it now has the same state vars (owner address) as the DogUpdated contract
    proxyDog.initialise(accounts[0]);

    //check that storage remained
    noOfDogs = await proxyDog.getNumberOfDogs();
    console.log(noOfDogs.toNumber());

    await proxyDog.setNumberOfDogs(50);
    noOfDogs = await proxyDog.getNumberOfDogs();
    console.log(noOfDogs.toNumber());
}