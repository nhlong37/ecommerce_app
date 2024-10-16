import 'package:ecommerce_app/Model/product.dart';
import 'package:flutter/material.dart';
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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.cart.length,
            itemBuilder: (context, index) {
              var product = widget.cart.keys.elementAt(index);
              var quantity = widget.cart.values.elementAt(index);
              return CartListItem(
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
              );
            },
          ),
        ),
      ],
    );
  }
}

class CartListItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final void Function(int) onAddCartClick;
  final void Function() onRemoveCartClick;
  const CartListItem({
    required Key key,
    required this.product,
    required this.quantity,
    required this.onAddCartClick,
    required this.onRemoveCartClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formartPrice = NumberFormat('#,##0 đ', 'vi');
    return Row(
      children: [
      Image.asset(product.image, width: 130, height: 130, fit: BoxFit.contain),
      Expanded(child: 
      Padding(padding: const EdgeInsets.all(10), child: Text(product.name),))
    ]);
  }
}
