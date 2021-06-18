import 'package:flutter/material.dart';
import 'package:project_zora/models/product.dart';
import 'package:project_zora/screens/shopper/shopper_search.dart';
import 'package:project_zora/services/database_service.dart';
import 'package:provider/provider.dart';

class ShopperLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
      value: DatabaseService().products,
      initialData: [],
      child: ShopperSearch(),
    );
  }
}
