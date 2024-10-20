import 'package:flutter/material.dart';
import 'package:ecommerce_app/Model/product.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen(this.product, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var formartPrice = NumberFormat('#,##0 đ', 'vi');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Column(
        children: [
          Image.asset(widget.product.image),
          Text(widget.product.name),
          Text(formartPrice.format(widget.product.price)),
          Text(widget.product.description),
        ],
      ),
    );
  }
}