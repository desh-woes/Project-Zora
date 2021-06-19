import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome!",
                  style:
                      TextStyle(color: fontType, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    "images/switch_to_shopper.svg",
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
                  },
                ),
              ],
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
                      Navigator.pushNamed(context, "/searchBar");
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
            if (products.length > 0)
              Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height / 2,
                      minWidth: double.infinity,
                      maxHeight: MediaQuery.of(context).size.height / 2),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: CupertinoScrollbar(
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
                    ),
                  ))
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("images/no_search_result.png"),
                  Center(
                    child: Text(
                      "Ooops!\nNo one has added a product",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 16,
                        color: fontType.withOpacity(0.85),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
