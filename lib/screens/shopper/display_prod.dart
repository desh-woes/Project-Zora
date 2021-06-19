import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_zora/models/product.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayProductPage extends StatelessWidget {
  getImages(Product product) {
    var imageList = [];

    if (product.productImageUrl1 != "" || product.productImageUrl1 != null) {
      imageList.add(Image.network(
        product.productImageUrl1,
        fit: BoxFit.cover,
      ));
    }
    if (product.productImageUrl2 != "" || product.productImageUrl2 != null) {
      imageList.add(Image.network(
        product.productImageUrl2,
        fit: BoxFit.cover,
      ));
    }
    if (product.productImageUrl3 != "" || product.productImageUrl3 != null) {
      imageList.add(Image.network(
        product.productImageUrl3,
        fit: BoxFit.cover,
      ));
    }

    if (imageList.length == 0) {
      imageList.add(Image.network(
        defaultUrl,
        fit: BoxFit.cover,
      ));
    }

    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 30)),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.productName,
                      style: TextStyle(
                        color: fontType.withOpacity(0.75),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                        color: fontType.withOpacity(0.75),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 30)),
            ],
          ),
          SizedBox(
            height: 200.0,
            width: double.infinity,
            child: Carousel(
              autoplay: false,
              dotSize: 4.0,
              dotSpacing: 15.0,
              images: getImages(product),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Price",
                        style: TextStyle(
                          color: fontType.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "RWF ${product.productPrice}",
                        style: TextStyle(
                          color: fontType,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vendor details",
                        style: TextStyle(
                          color: fontType.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Call Number",
                            style: TextStyle(
                              color: fontType.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 5)),
                          IconButton(
                            onPressed: () {
                              launch("tel://0${product.productStoreNumber}");
                            },
                            icon: SvgPicture.asset("images/call_number.svg"),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.productStoreName,
                        style: TextStyle(
                          color: fontType,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Copy Number",
                            style: TextStyle(
                              color: fontType.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 5)),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(new ClipboardData(
                                      text: product.productStoreNumber))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Phone number copied to clipboard")));
                              });
                            },
                            icon: SvgPicture.asset("images/copy_number.svg"),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    "Product description",
                    style: TextStyle(
                      color: fontType.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    product.productDescription,
                    style: TextStyle(
                      color: fontType.withOpacity(0.85),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product State",
                        style: TextStyle(
                          color: fontType.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        color: softWork,
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                        child: Text(
                          product.productState,
                          style: TextStyle(
                            color: fontType,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(15)),
                  Text(
                    "Delivery Address",
                    style: TextStyle(
                      color: fontType.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    product.productStoreLocation,
                    style: TextStyle(
                      color: fontType,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
