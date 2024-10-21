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
              color: Color(0xfff0f0f0),
            ),
            SizedBox(height: 15,),
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
                      height: 49,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF4F4F4),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFE7E7E7)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 203,
                      height: 49,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: ShapeDecoration(
                        color: Color(0xFF0A70B8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.50, vertical: 1.67),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 15,
                                  height: 16.67,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/15x17"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Thêm vào giỏ hàng',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              height: 0.11,
                            ),
                          ),
                        ],
                      ),
                    )
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
