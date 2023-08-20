//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import "erc20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
contract FungibleToken is ERC20("Fungible Token", "FT"){

    struct Customer{
        string name;
        string email;
        string password;
        address customerAddress;
        bool isLoyal;
        uint currLoyalPoints;
        uint totalTokens;
    }

    struct Brand{
        string name;
        string email;
        address brandAddress;
        uint currLoyalPoints;
    }

    struct CustomerSignature{
        string name;
        string password;
        address customerAddress;
    }

    address public flipkart;
    mapping(address=>mapping(address=>uint)) private moneyTrack;
    mapping(address=>uint) private thresholdLoyal;
    mapping(address=>Customer) private customers;
    mapping(string=>Brand) private brands;
    mapping(address=>Customer[]) private loyalCustomers;// key=brandAdress, value= Customer
    mapping(string=>CustomerSignature) private signedCustomers;
    address[] signedBrands;

    function startSystem() public {
        flipkart=msg.sender;//flipkart address
    }

    modifier flipkartOnly(){
        require(msg.sender==flipkart);
        _;
    }

    modifier SignedBrandOnly(address brandAddress,address customerAddress){
        require(exists(brandAddress)&&brandAddress!=customerAddress);
        _;
    }

    function addBrand(string memory name,string memory email,address brandAddress,uint threshold) flipkartOnly public{
        brands[email]=Brand(name,email,brandAddress,0);
        signedBrands.push(brandAddress);
        thresholdLoyal[brandAddress]=threshold;
    }

    function makeMyLoyalCustomer(address brandAddress,address customerAddress) public{
        loyalCustomers[brandAddress].push(customers[customerAddress]);
    }

    function addCustomer(string memory name,string memory email,string memory password,address customerAddress) public{
        resetBalance(customerAddress);
        customers[customerAddress]=Customer(name,email,password,customerAddress,false,0,0);
        signedCustomers[email]=CustomerSignature(name,password,customerAddress);
    }

    function decayTokens(address customerAddress,uint256 cost) flipkartOnly public{
        decayBalance(customerAddress,cost);
        if(cost<=customers[customerAddress].currLoyalPoints){
            customers[customerAddress].currLoyalPoints-=cost;
        }
    }

    function getUserData(string memory email)public view returns(Customer memory){
        CustomerSignature memory cs=signedCustomers[email];
        return customers[cs.customerAddress];
    }   

    function getBrandAddress(string memory email) public view returns(address){
        return brands[email].brandAddress;
    }

    function makeCustomerLoyal(address customerAddress) flipkartOnly public{
        customers[customerAddress].isLoyal=true;
    }

    function increaseLoyaltyPoints(address customerAddress) flipkartOnly public{
        require(customers[customerAddress].isLoyal);
        customers[customerAddress].currLoyalPoints++;
    }

    function mintDailyCheckInLoyaltyPoints(address customerAddress) flipkartOnly public{
        _mint(customerAddress, 1 * 10**18);//user address , loyalty points
        customers[customerAddress].currLoyalPoints+=1;
    }

    function mintLoyaltyPoints(address customerAddress,uint points) flipkartOnly public {
        require(customers[customerAddress].isLoyal);
        _mint(customerAddress, points * 10**18);//user address , loyalty points
        customers[customerAddress].currLoyalPoints+=points;
    }

    function transferToMyFriend(address sender,address reciever,uint points) public{
        //require(customers[msg.sender].isLoyal&&customers[customerAddress].isLoyal&&msg.sender!=customerAddress);
        transferFrom(sender, reciever, points*10**18);
    }

    function exists(address brandAddress) public view returns(bool){
        for(uint i=0;i<signedBrands.length;i++){
            if(signedBrands[i]==brandAddress){
                return true;
            }
        }
        return false;
    }

    function buyUsingFungibleToken(address customerAddress,address brandAddress,uint cost) SignedBrandOnly(brandAddress,customerAddress) public{
        require(customers[customerAddress].currLoyalPoints>=cost);
        _transfer(customerAddress, brandAddress, cost*10**18);
        customers[customerAddress].currLoyalPoints-=cost;
    }

    function updateMoneySpendOnBrand(address brandAddress,address customerAddress,uint moneyAmount) public{
        moneyTrack[brandAddress][customerAddress]+=moneyAmount;
        if(moneyTrack[brandAddress][customerAddress]>thresholdLoyal[brandAddress]){
            makeMyLoyalCustomer(brandAddress, customerAddress);
        }
    }

    function isCustomerMyLoyalCustomer(address brandAddress,address customerAddress) public view returns(bool){
        Customer memory cs=customers[customerAddress];
        for(uint i=0;i<loyalCustomers[brandAddress].length;i++){
            if(loyalCustomers[brandAddress][i].customerAddress==cs.customerAddress){
                return true;
            }
        }
        return false;
    }

}