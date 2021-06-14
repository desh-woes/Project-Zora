import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_zora/models/product.dart';
import 'package:project_zora/screens/product_listing/merchant_products/product_tile.dart';

class ProductList extends StatefulWidget {
  final List<Product> products;

  ProductList({this.products});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return ProductTile(
            product: widget.products[index],
          );
        },
      ),
    );
  }
}
