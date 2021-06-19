import 'package:flutter/material.dart';
import 'package:project_zora/models/product.dart';
import 'package:project_zora/shared/constants.dart';

class ShopperSearchTile extends StatelessWidget {
  final Product product;

  const ShopperSearchTile({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/displayProductPage", arguments: product);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              child: Container(
                width: 100,
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
                        color: thotBlue,
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
            //  content
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 20, top: 12, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // product name
                        Text(
                          product.productName,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: fontType.withOpacity(0.75)),
                        ),
                        Padding(padding: const EdgeInsets.only(bottom: 3)),
                        //
                        Text(
                          product.productStoreName,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: fontType.withOpacity(0.5)),
                        ),
                        Padding(padding: const EdgeInsets.only(bottom: 3)),
                        // price
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "RWF ${product.productPrice}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: fontType,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
