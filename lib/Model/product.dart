class Product {
  int id;
  String name;
  String description;
  int price;
  String image;
    
  Product(
    {
      required this.id,
      required this.price,
      required this.name,
      required this.description, 
      required this.image,
    }
  );
}