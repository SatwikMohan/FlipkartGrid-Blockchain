class Usertest {
  final String name;
  final String password;
  final String userImage;
  final String ethereumWallet;
  final int loyaltyPoints;
  final int loginStreakCount;
  final List<Transaction> transactionHistory;

  Usertest({
    required this.name,
    required this.password,
    required this.userImage,
    required this.ethereumWallet,
    required this.loyaltyPoints,
    required this.loginStreakCount,
    required this.transactionHistory,
  });
}

class Transaction {
  final String description;
  final double amount;

  Transaction({required this.description, required this.amount});
}

final Usertest userTest = Usertest(
  name: 'John Doe',
  password: 'password123',
  userImage: 'https://example.com/user_image.jpg',
  ethereumWallet: '0xabc123def456...',
  loyaltyPoints: 500,
  loginStreakCount: 10,
  transactionHistory: [
    Transaction(description: 'Product A', amount: -50.0),
    Transaction(description: 'Product B', amount: -75.0),
    // Add more transactions here
  ],
);

class Product {
  final String name;
  final String company;
  final int price;
  final String description;
  final double rating;
  final String image;

  Product({
    required this.name,
    required this.company,
    required this.price,
    required this.description,
    required this.rating,
    required this.image,
  });
}

final List<Product> products = [
  Product(
    name: 'Product 1',
    company: 'Company A',
    price: 2,
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    rating: 4.5,
    image:
        'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_1280.jpg',
  ),
  Product(
    name: 'Product 2',
    company: 'Company B',
    price: 3,
    description:
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    rating: 4.0,
    image:
        'https://e0.pxfuel.com/wallpapers/692/714/desktop-wallpaper-beautiful-nature-latest-beauty-nature.jpg',
  ),
  // Add more products as needed
];
