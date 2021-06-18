import 'package:flutter/material.dart';
import 'package:project_zora/screens/shopper/shopper_search_tile.dart';
import 'package:project_zora/services/database_service.dart';
import 'package:project_zora/shared/constants.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var queryResultSet = [];
  var tempSearchStore = [];

  String currentSearchVal = "";

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var normalizedValue;
    if (value == null || value.length == 0) {
      normalizedValue = "";
    } else if (value.length == 1) {
      normalizedValue = value.substring(0, 1).toLowerCase();
    } else {
      normalizedValue =
          value.substring(0, 1).toLowerCase() + value.substring(1);
    }

    if (queryResultSet.length == 0 && normalizedValue.length == 1) {
      DatabaseService().searchByName(normalizedValue).then((docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          setState(() {
            queryResultSet.add(docs.docs[i].data());
            tempSearchStore.add(docs.docs[i].data());
          });
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['productName'].toLowerCase().startsWith(normalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Search",
                style: TextStyle(color: fontType, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Container(
            color: Color(0xFFFAFAFA),
            child: TextField(
              autofocus: true,
              onChanged: (val) {
                initiateSearch(val);
                setState(() {
                  currentSearchVal = val;
                });
              },
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: fontType,
                  icon: Icon(Icons.search),
                  iconSize: 16.0,
                  onPressed: () {
                    // Not Implemented
                  },
                ),
                contentPadding: EdgeInsets.only(left: 25.0),
                hintText: "Search by product name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0)),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Showing results for",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: fontType),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "\"$currentSearchVal\"",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: fontType),
          ),
          if (tempSearchStore.length > 0 || currentSearchVal == "")
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: tempSearchStore.length,
                itemBuilder: (context, index) {
                  return ShopperSearchTile(
                    product: DatabaseService()
                        .productListFromDocument(tempSearchStore[index]),
                  );
                },
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("images/no_search_result.png"),
                Center(
                  child: Text(
                    "Ooops!\nNo one has added the product\nyou’re looking for yet.",
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
    ));
  }
}
