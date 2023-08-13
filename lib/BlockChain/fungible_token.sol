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
    function startSystem() public {
        flipkart=msg.sender;//flipkart address
    }
    modifier flipkartOnly(){
        require(msg.sender==flipkart);
        _;
    }

    mapping(address=>Customer) private customers;
    mapping(string=>Brand) private brands;
    mapping(address=>Customer[]) private loyalCustomers;// key=brandAdress, value= Customer
    mapping(string=>CustomerSignature) private signedCustomers;
    address[] signedBrands;

    function addBrand(string memory name,string memory email,address brandAddress) flipkartOnly public{
        brands[email]=Brand(name,email,brandAddress,0);
        signedBrands.push(brandAddress);
    }

    modifier BrandOnly(address brandAddress){
        require(msg.sender==brandAddress);
        _;
    }

    function makeMyLoyalCustomer(address brandAddress,address customerAddress) BrandOnly(brandAddress) public {
        loyalCustomers[brandAddress].push(customers[customerAddress]);
    }

    function addCustomer(string memory name,string memory email,string memory password,address customerAddress) public{
        resetBalance(customerAddress);
        customers[customerAddress]=Customer(name,email,password,customerAddress,false,0,0);
        signedCustomers[email]=CustomerSignature(name,password,customerAddress);
    }

    function getUserData(string memory email)public view returns(Customer memory){
        CustomerSignature memory cs=signedCustomers[email];
        return customers[cs.customerAddress];
    }

    function makeCustomerLoyal(address customerAddress) flipkartOnly public{
        customers[customerAddress].isLoyal=true;
    }

    function increaseLoyaltyPoints(address customerAddress) flipkartOnly public{
        require(customers[customerAddress].isLoyal);
        customers[customerAddress].currLoyalPoints++;
    }

    function mintDailyCheckInLoyaltyPoints(address customerAddress) flipkartOnly public{
        // require(customers[customerAddress].isLoyal);
        _mint(customerAddress, 1 * 10**18);//user address , loyalty points
        customers[customerAddress].currLoyalPoints+=1;
    }

    function mintLoyaltyPoints(address customerAddress,uint points) flipkartOnly public {
        require(customers[customerAddress].isLoyal);
        _mint(customerAddress, points * 10**18);//user address , loyalty points
        customers[customerAddress].currLoyalPoints+=points;
    }

    function transferToMyLoyalCustomer(address customerAddress,uint points) public{
        require(customers[msg.sender].isLoyal&&customers[customerAddress].isLoyal&&msg.sender!=customerAddress);
        transferFrom(msg.sender, customerAddress, points*10**18);
    }

    function exists(address brandAddress) public view returns(bool){
        for(uint i=0;i<signedBrands.length;i++){
            if(signedBrands[i]==brandAddress){
                return true;
            }
        }
        return false;
    }

    modifier SignedBrandOnly(address brandAddress){
        require(exists(brandAddress));
        _;
    }

    function buyUsingFungibleToken(address customerAddress,address brandAddress,uint cost) SignedBrandOnly(brandAddress) public{
        transferFrom(customerAddress, brandAddress, cost*10**18);
        customers[customerAddress].currLoyalPoints-=cost;
    }

}