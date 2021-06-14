import 'package:project_zora/models/product.dart';

class FilterProductList {
  String uid;
  List<Product> productList;

  FilterProductList({this.uid, this.productList});

  List<Product> filterProductList() {
    final result = <Product>[];
    productList.forEach((product) {
      if (product.uid == uid) {
        result.add(product);
      }
    });
    return result;
  }
}
