import 'package:flutter/material.dart';
import 'package:ecommerce_app/Model/product.dart';
import 'package:intl/intl.dart';
import 'cart.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen(this.product, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var formartPrice = NumberFormat('#,##0 đ', 'vi');
  int quantity = 1;
  TextEditingController _quantityController = TextEditingController();
  final Map<Product, int> _cart = {};

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _quantityController = new TextEditingController(text: '1');
  }

  void _addToCart(Product product, [int quantity = 1]) {
    setState(() {
      if (!_cart.containsKey(product) && quantity <= 0) {
        return;
      }
      _cart[product] = (_cart[product] ?? 0) + quantity;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.product.name, style: TextStyle(fontSize: 25)),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CartScreen(_cart, _removeFromCart, _addToCart),
                          ));
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    )),
                Text(
                  "(${_cart.isNotEmpty ? _cart.values.reduce((sum, val) => sum + val) : 0})",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Center(
                child:
                    Image.asset(widget.product.image, width: 300, height: 300),
              ),
            ),
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              formartPrice.format(widget.product.price),
              style: TextStyle(fontSize: 18, color: Color(0xffe82727)),
            ),
            SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.product.description,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              width: double.maxFinite,
              height: 1,
              color: Color.fromARGB(255, 199, 199, 199),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Số lượng"),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Container(
                      width: 127,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Color(0xfff4f4f4),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Color(0xffe8e8e8)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _quantityController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_quantityController.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Thông Báo',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black)),
                                  content: Text('Vui lòng nhập số lượng!!!',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Tắt',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              );
                          } else if (int.parse(_quantityController.text) <= 0) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Thông Báo',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black)),
                                  content: Text('Vui lòng nhập số lượng >= 1',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Tắt',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              );
                          } else if (int.parse(_quantityController.text) >= 999) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Thông Báo',
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.black)),
                                  content: Text('Số lượng nhập quá lớn!!!',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black)),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shadowColor: Colors.transparent
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Tắt',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              );
                          } else {
                            _addToCart(widget.product,
                                int.parse(_quantityController.text));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Container(
                          height: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon( Icons.add_shopping_cart, color: Colors.white,),
                              SizedBox(width: 8),
                              Text(
                                'Thêm vào giỏ hàng',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
