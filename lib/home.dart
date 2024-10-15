import 'package:ecommerce_app/Model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> _products = [];
  final Map<Product, int> _cart = {};
  var formartPrice = NumberFormat('#,##0 đ', 'vi');
  @override
  void initState() {
    super.initState();
    // Show product list
    for (int i = 1; i <= 10; i++) {
      _products.add(Product(
          id: i,
          price: i * 10000,
          name: 'Sản phẩm $i',
          description:
              'Sản phẩm $i - là cuốn sách dành cho những ai muốn thành công trong sự nghiệp. Tác giả chia sẻ những bí quyết, kỹ năng đàm phán, thuyết trình hiệu quả giúp bạn chinh phục mọi đối tượng.',
          image: 'images/$i.jpg'));
    }
  }

  void _addToCart(Product product, [int quantity = 1]) {
    setState(() {
      if (!_cart.containsKey(product) && quantity <= 0) {
        return;
      }
      _cart[product] = _cart[product] ?? 0 + quantity;
      if (_cart[product]! <= 0) {
        _cart[product] = 1;
      }
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      if (_cart.containsKey(product)) {
        _cart.remove(product);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Home Screen', style: TextStyle(fontSize: 25)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.shopping_bag,
                        color: Colors.black,
                      )),
                  Text(
                    "(1)",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text('Danh Sách Sản Phẩm',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 10),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          var _itemProduct = _products[index];
                          return FloatingActionButton(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            hoverColor: Colors.black.withOpacity(0.1),
                            onPressed: (){}, 
                            child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.asset(_itemProduct.image,
                                        width: 540, height: 800),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(_itemProduct.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                      Text(formartPrice.format(_itemProduct.price)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                        })),
              ),
            ],
          ),
        ));
  }
}
