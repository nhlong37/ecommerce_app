import 'package:flutter/material.dart';
import 'package:ecommerce_app/Model/product.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  final Map<Product, int> cart;
  final void Function(Product) onRemoveCart;
  final void Function(Product, int) onAddCart;
  const CartScreen(this.cart, this.onRemoveCart, this.onAddCart, {super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {
                  var product = widget.cart.keys.elementAt(index);
                  var quantity = widget.cart.values.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardListItem(
                      key: Key(product.id.toString()),
                      product: product,
                      quantity: quantity,
                      onAddCartClick: (quantity) {
                        setState(() {
                          widget.onAddCart(product, quantity);
                        });
                      },
                      onRemoveCartClick: () {
                        setState(() {
                          widget.onRemoveCart(product);
                        });
                      },
                    ),
                  );
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Tổng: ${widget.cart.entries.fold(0, (sum, entry) => sum + entry.key.price * entry.value)}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardListItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final void Function(int) onAddCartClick;
  final void Function() onRemoveCartClick;
  const CardListItem(
      {required Key key,
      required this.product,
      required this.quantity,
      required this.onAddCartClick,
      required this.onRemoveCartClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formartPrice = NumberFormat('#,##0 đ', 'vi');

    return Row(
      children: [
        Image.asset(product.image,
            width: 130, height: 130, fit: BoxFit.contain),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${formartPrice.format(product.price)}',
                    style: const TextStyle(color: Color.fromARGB(1, 220, 20, 60)),
                  ),
                  const SizedBox(width: 10),
                  Text('X $quantity'),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.remove_sharp),
                          onPressed: quantity > 1
                              ? () {
                                  onAddCartClick(-1);
                                }
                              : null),
                      IconButton(
                        icon: const Icon(Icons.add_sharp),
                        onPressed: () => onAddCartClick(1),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Text('${formartPrice.format(product.price * quantity)}'),
                  IconButton(
                    icon: const Icon(Icons.delete_forever_sharp),
                    hoverColor: Color(Colors.red.value),
                    
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Xác nhận'),
                          content: Text(
                            'Bạn có muốn xoá ${product.name} ra khỏi giỏ hàng?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Huỷ'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ).then((val) {
                        if (val != null && val) {
                          onRemoveCartClick();
                        }
                      });
                    },
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
