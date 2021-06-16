import 'package:flutter/material.dart';
import 'package:project_zora/models/product.dart';
import 'package:project_zora/shared/constants.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              child: Container(
                width: 80,
                height: double.infinity,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                    product.productImageUrl1,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ));
                    },
                  ),
                ),
              ),
            ),

            Padding(padding: const EdgeInsets.all(5)),
            //  content
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // product name
                        Text(
                          product.productName,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: fontType),
                        ),
                        // price
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "RWF ${product.productPrice}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: fontType.withOpacity(0.5)),
                              )
                            ],
                          ),
                        )
                      ],
                    )))
          ],
        ));
  }
}
