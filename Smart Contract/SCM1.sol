// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 < 0.9.0;

contract SCM1 {
    address public owner = payable(msg.sender);

    enum Role {
        Farmer,
        Distributor,
        Vendor
    }

    struct User_Type {
        uint id;
        string name;
        string email;
        Role role;
    }

    struct Farmer_Post {
        uint Farmer_Post_id;
        address Farmer_address;
        string Product_name;
        string Product_description;
        string Product_img;
        uint Product_quantity;
        uint Farmer_price;
        address[] from;
        string[] from_name;
        address[] to;
        string[] to_name;
        uint[] value;
    }

    struct Distributor_Post {
        uint Distributor_Post_id;
        uint Farmer_Post_id;
        // address Farmer_address;
        address Distributor_address;
        string Product_name;
        string Product_description;
        string Product_img;
        uint Product_quantity;
        uint Distributor_price;
        address[] from;
        string[] from_name;
        address[] to;
        string[] to_name;
        uint[] value;
    }

    struct Vendor_Post {
        uint Vendor_Post_id;
        uint Distributor_Post_id;
        // address Farmer_address;
        address Vendor_address;
        string Product_name;
        string Product_description;
        // string Product_img;
        uint Product_quantity;
        uint Vendor_price;
        address[] from;
        string[] from_name;
        address[] to;
        string[] to_name;
        uint[] value;
    }

    uint public User_Type_Counter;

    uint public Farmer_Post_Counter;

    uint public Distributor_Post_Counter;

    uint public Vendor_Post_Counter;

    mapping (address => User_Type) public User_Type_Mapping;

    Farmer_Post[] public Farmer_Post_Array;

    Distributor_Post[] public Distributor_Post_Array;

    Vendor_Post[] public Vendor_Post_Array;

    function Register_User_Type(string calldata name, string calldata email, Role role) public {
        require(bytes(User_Type_Mapping[msg.sender].name).length == 0, "You are already registered");
        User_Type memory User_Type1;
        User_Type1.id = User_Type_Counter++;
        User_Type1.name = name;
        User_Type1.email = email;
        User_Type1.role = role;
        User_Type_Mapping[msg.sender] = User_Type1;
    }

    function Farmer_Post_Create(string memory Product_name, string memory Product_description, uint Product_quantity, string memory Product_img, uint Farmer_price) public {
        require(User_Type_Mapping[msg.sender].role == Role.Farmer, "You are not the Farmer");
        Farmer_Post memory Farmer_Post1; 
        Farmer_Post1.Farmer_Post_id = Farmer_Post_Counter++;
        Farmer_Post1.Farmer_address = payable(msg.sender);
        Farmer_Post1.Product_name = Product_name;
        Farmer_Post1.Product_description = Product_description;
        Farmer_Post1.Product_quantity = Product_quantity;
        Farmer_Post1.Product_img = Product_img;
        Farmer_Post1.Farmer_price = Farmer_price;
        Farmer_Post_Array.push(Farmer_Post1);
    }

    function Transfer_to_Farmer(uint Farmer_Post_id) public payable  {
        require(User_Type_Mapping[msg.sender].role == Role.Distributor, "You are not the Distributor");
        payable(Farmer_Post_Array[Farmer_Post_id].Farmer_address).transfer(msg.value);
        Farmer_Post_Array[Farmer_Post_id].from.push(msg.sender);
        Farmer_Post_Array[Farmer_Post_id].from_name.push(string(abi.encodePacked(User_Type_Mapping[msg.sender].name,"(Distributor)")));
        Farmer_Post_Array[Farmer_Post_id].to.push(Farmer_Post_Array[Farmer_Post_id].Farmer_address);
        Farmer_Post_Array[Farmer_Post_id].to_name.push(string(abi.encodePacked(User_Type_Mapping[Farmer_Post_Array[Farmer_Post_id].Farmer_address].name,"(Farmer)")));
        Farmer_Post_Array[Farmer_Post_id].value.push(msg.value);
    }

    function Farmer_Post_Display() public view returns(Farmer_Post[] memory) {
        return Farmer_Post_Array;
    }

    // function Farmer_Post_Display(uint Farmer_Post_id) public view returns(Farmer_Post memory) {
    //     return Farmer_Post_Array[Farmer_Post_id];
    // }

    // function Distributor_Post_Create(uint Farmer_Post_id, uint Distributor_price) public {
    //     require(User_Type_Mapping[msg.sender].role == Role.Distributor, "You are not the Distributor");
    //     Distributor_Post memory Distributor_Post1;
    //     Distributor_Post1.Distributor_Post_id = Distributor_Post_Counter++;
    //     Distributor_Post1.Farmer_Post_id = Farmer_Post_id;
    //     // Distributor_Post1.Farmer_address = Farmer_Post_Array[Farmer_Post_id].Farmer_address;
    //     Distributor_Post1.Distributor_address = msg.sender;
    //     Distributor_Post1.Product_name = Farmer_Post_Array[Farmer_Post_id].Product_name;
    //     Distributor_Post1.Product_description = Farmer_Post_Array[Farmer_Post_id].Product_description;
    //     Distributor_Post1.Product_quantity = Farmer_Post_Array[Farmer_Post_id].Product_quantity;
    //     Distributor_Post1.Product_img = Farmer_Post_Array[Farmer_Post_id].Product_img;
    //     Distributor_Post1.Distributor_price = Distributor_price;
    //     Distributor_Post_Array.push(Distributor_Post1);
    // }

    // function Transfer_to_Distributor(uint Distributor_Post_id, uint quantity) public payable  {
    //     require(User_Type_Mapping[msg.sender].role == Role.Vendor, "You are not the Vendor");
    //     require(quantity < Distributor_Post_Array[Distributor_Post_id].Product_quantity, "Please enter the correct quantity");
    //     uint value = quantity * Distributor_Post_Array[Distributor_Post_id].Distributor_price;
    //     payable(Distributor_Post_Array[Distributor_Post_id].Distributor_address).transfer(value);
    //     Farmer_Post_Array[Distributor_Post_Array[Distributor_Post_id].Farmer_Post_id].from.push(msg.sender);
    //     Farmer_Post_Array[Distributor_Post_Array[Distributor_Post_id].Farmer_Post_id].from_name.push(string(abi.encodePacked(User_Type_Mapping[msg.sender].name,"(Vendor)")));
    //     Farmer_Post_Array[Distributor_Post_Array[Distributor_Post_id].Farmer_Post_id].to.push(Distributor_Post_Array[Distributor_Post_id].Distributor_address);
    //     Farmer_Post_Array[Distributor_Post_Array[Distributor_Post_id].Farmer_Post_id].to_name.push(string(abi.encodePacked(User_Type_Mapping[Distributor_Post_Array[Distributor_Post_id].Distributor_address].name,"(Distributor)")));
    //     Farmer_Post_Array[Distributor_Post_Array[Distributor_Post_id].Farmer_Post_id].value.push(value);

    //     Distributor_Post_Array[Distributor_Post_id].from.push(msg.sender);
    //     Distributor_Post_Array[Distributor_Post_id].from_name.push(string(abi.encodePacked(User_Type_Mapping[msg.sender].name,"(Vendor)")));
    //     Distributor_Post_Array[Distributor_Post_id].to.push(Distributor_Post_Array[Distributor_Post_id].Distributor_address);
    //     Distributor_Post_Array[Distributor_Post_id].to_name.push(string(abi.encodePacked(User_Type_Mapping[Distributor_Post_Array[Distributor_Post_id].Distributor_address].name,"(Distributor)")));
    //     Distributor_Post_Array[Distributor_Post_id].value.push(value);
    //     Distributor_Post_Array[Distributor_Post_id].Product_quantity -= quantity;
    // }

    // function Distributor_Post_Display(uint Distributor_Post_id) public view returns(Distributor_Post memory) {
    //     return Distributor_Post_Array[Distributor_Post_id];
    // }

    // function Vendor_Post_Create(uint Distributor_Post_id, uint Vendor_price) public {
    //     require(User_Type_Mapping[msg.sender].role == Role.Vendor, "You are not the Vendor");
    //     Vendor_Post memory Vendor_Post1;
    //     Vendor_Post1.Vendor_Post_id = Vendor_Post_Counter++;
    //     Vendor_Post1.Distributor_Post_id = Distributor_Post_id;
    //     // Distributor_Post1.Farmer_address = Farmer_Post_Array[Farmer_Post_id].Farmer_address;
    //     Vendor_Post1.Vendor_address = msg.sender;
    //     Vendor_Post1.Product_name = Distributor_Post_Array[Distributor_Post_id].Product_name;
    //     Vendor_Post1.Product_description = Distributor_Post_Array[Distributor_Post_id].Product_description;
    //     Vendor_Post1.Product_quantity = Distributor_Post_Array[Distributor_Post_id].Product_quantity;
    //     // Vendor_Post1.Product_img = Distributor_Post_Array[Distributor_Post_id].Product_img;
    //     Vendor_Post1.Vendor_price = Vendor_price;
    //     Vendor_Post_Array.push(Vendor_Post1);
    // }

    // function Transfer_to_Vendor(uint Vendor_Post_id, uint quantity) public payable  {
    //     require(User_Type_Mapping[msg.sender].role != Role.Farmer || User_Type_Mapping[msg.sender].role != Role.Distributor || User_Type_Mapping[msg.sender].role != Role.Vendor, "You are not the Customer");
    //     require(quantity < Vendor_Post_Array[Vendor_Post_id].Product_quantity, "Please enter the correct quantity");
    //     uint value = quantity * Vendor_Post_Array[Vendor_Post_id].Vendor_price;

    //     uint part1 = (value * 30) / 100;  // 30% of the value
    //     uint part2 = (value * 20) / 100;  // 10% of the value
    //     uint part3 = (value * 50) / 100;  // 50% of the value

    //     payable(Vendor_Post_Array[Vendor_Post_id].Vendor_address).transfer(part3);
    //     payable(Distributor_Post_Array[Vendor_Post_Array[Vendor_Post_id].Distributor_Post_id].Distributor_address).transfer(part2);
    //     payable(Farmer_Post_Array[Distributor_Post_Array[Vendor_Post_Array[Vendor_Post_id].Distributor_Post_id].Farmer_Post_id].Farmer_address).transfer(part1);

    //     // payable(Vendor_Post_Array[Vendor_Post_id].Vendor_address).transfer(value);

    //     Farmer_Post_Array[Distributor_Post_Array[Vendor_Post_Array[Vendor_Post_id].Distributor_Post_id].Farmer_Post_id].from.push(msg.sender);
    //     Farmer_Post_Array[Distributor_Post_Array[Vendor_Post_Array[Vendor_Post_id].Distributor_Post_id].Farmer_Post_id].from_name.push("Customer");
    //     Farmer_Post_Array[Distributor_Post_Array[Vendor_Post_Array[Vendor_Post_id].Distributor_Post_id].Farmer_Post_id].to.push(Vendor_Post_Array[Vendor_Post_id].Vendor_address);
    //     Farmer_Post_Array[Distributor_Post_Array[Vendor_Post_Array[Vendor_Post_id].Distributor_Post_id].Farmer_Post_id].to_name.push(string(abi.encodePacked(User_Type_Mapping[Vendor_Post_Array[Vendor_Post_id].Vendor_address].name,"(Vendor)")));
    //     Farmer_Post_Array[Distributor_Post_Array[Vendor_Post_Array[Vendor_Post_id].Distributor_Post_id].Farmer_Post_id].value.push(value);

    //     Vendor_Post_Array[Vendor_Post_id].from.push(msg.sender);
    //     Vendor_Post_Array[Vendor_Post_id].from_name.push("Customer");
    //     Vendor_Post_Array[Vendor_Post_id].to.push(Vendor_Post_Array[Vendor_Post_id].Vendor_address);
    //     Vendor_Post_Array[Vendor_Post_id].to_name.push(string(abi.encodePacked(User_Type_Mapping[Vendor_Post_Array[Vendor_Post_id].Vendor_address].name,"(Vendor)")));
    //     Vendor_Post_Array[Vendor_Post_id].value.push(value);
    //     Vendor_Post_Array[Vendor_Post_id].Product_quantity -= quantity;
    // }

    // function Vendor_Post_Display(uint Vendor_Post_id) public view returns(Vendor_Post memory) {
    //     return Vendor_Post_Array[Vendor_Post_id];
    // }
}