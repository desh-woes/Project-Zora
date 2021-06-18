import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_zora/models/product.dart';
import 'package:project_zora/screens/shopper/shopper_search_tile.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:provider/provider.dart';

class ShopperSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Welcome!",
              style: TextStyle(color: fontType, fontWeight: FontWeight.w600),
            ),
            Padding(padding: const EdgeInsets.all(25)),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(
                        "images/shopper_page_illustration.png",
                      ),
                      Padding(padding: const EdgeInsets.only(bottom: 35)),
                      Text(
                        "Let’s find that\nproduct you need",
                        style: TextStyle(
                            color: fontType,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ],
                  ),
                  Image.asset("images/swirly_Arrow.png")
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.all(25)),
            Container(
              height: 50,
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Implement Search
                    },
                    icon: Icon(
                      Icons.search_sharp,
                      color: thotBlue,
                      size: 20,
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    onTap: () {
                      // Not yet Implemented
                    },
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "What are you looking for?",
                        hintStyle: TextStyle(fontSize: 12)),
                  )),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.all(20)),
            Text(
              "Featured Products",
              style: TextStyle(
                  color: fontType.withOpacity(0.75),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            // Padding(padding: const EdgeInsets.all(5)),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ShopperSearchTile(
                    product: products[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
