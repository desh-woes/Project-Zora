import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:project_zora/models/merchant.dart';
import 'package:project_zora/services/database_service.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/shared/loading.dart';
import 'package:project_zora/shared/product_picture_upload.dart';
import 'package:project_zora/shared/profile_pic.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return StreamBuilder<MerchantData>(
      stream: DatabaseService(uid: user.uid).merchantData,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          MerchantData merchantData = snapshot.data;
          return AddProductBuilder(
            merchantData: merchantData,
            user: user,
          );
        }
        return Loading();
      },
    );
  }
}

class AddProductBuilder extends StatefulWidget {
  final MerchantData merchantData;
  final User user;

  AddProductBuilder({@required this.merchantData, @required this.user});

  @override
  _AddProductBuilderState createState() => _AddProductBuilderState();
}

class _AddProductBuilderState extends State<AddProductBuilder> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final productPriceController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final snackBar = SnackBar(content: Text('Yay! A new product has been added'));
  bool loading = false;
  String defaultImageUrl = defaultUrl;
  String productImg1;
  String productImg2;
  String productImg3;
  String productState;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 25,
                    child: Align(
                      child: IconButton(
                        iconSize: 18,
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios, color: fontType),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 15.0)),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "New Product",
                          style: TextStyle(
                              fontSize: 24,
                              color: fontType,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        ProfilePic(
                          imagePath: widget.merchantData.profilePictureUrl,
                        )
                      ],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 15.0))
                ],
              ),
              elevation: 0.0,
              titleSpacing: 10.0,
              centerTitle: false,
            ),
            body: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Text(
                      "Product name",
                      style: TextStyle(
                        color: grey,
                        fontSize: 14,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(5)),
                    TextFormField(
                        controller: productNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a valid product name";
                          }
                          return null;
                        },
                        decoration: registrationInputDecoration.copyWith(
                            hintText: "What's the name of this item?")),
                    Padding(padding: const EdgeInsets.all(20)),
                    Text(
                      "Upload a photo for the product",
                      style: TextStyle(
                        color: grey,
                        fontSize: 14,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(5)),
                    Container(
                      color: Colors.white,
                      height: 40,
                      child: DottedBorder(
                        color: Colors.black,
                        strokeWidth: 0.2,
                        child: Center(
                          child: Text(
                            "+ Add product photo",
                            style: TextStyle(color: thotBlue, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProductPicUpload(
                            imagePath: defaultImageUrl,
                            press: (val) {
                              setState(() {
                                productImg1 = val;
                              });
                            }),
                        ProductPicUpload(
                            imagePath: defaultImageUrl,
                            press: (val) {
                              setState(() {
                                productImg2 = val;
                              });
                            }),
                        ProductPicUpload(
                            imagePath: defaultImageUrl,
                            press: (val) {
                              setState(() {
                                productImg3 = val;
                              });
                            }),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(20)),
                    Text(
                      "How much is this product?",
                      style: TextStyle(
                        color: grey,
                        fontSize: 14,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(5)),
                    Row(
                      children: <Widget>[
                        Text(
                          "RWF",
                          style: TextStyle(color: fontType, fontSize: 14),
                        ),
                        Padding(padding: const EdgeInsets.all(5)),
                        Expanded(
                            child: Container(
                                child: TextFormField(
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                      signed: false,
                                      decimal: true,
                                    ),
                                    controller: productPriceController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter a valid product price";
                                      }
                                      return null;
                                    },
                                    decoration: registrationInputDecoration
                                        .copyWith(hintText: "0.00"))))
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(20)),
                    Text(
                      "What's the state of this product?",
                      style: TextStyle(
                        color: grey,
                        fontSize: 14,
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 20,
                          margin: EdgeInsets.only(right: 20),
                          child: Radio(
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.isEmpty) {
                                return radio;
                              }
                              return thotBlue;
                            }),
                            value: "Brand New",
                            groupValue: productState,
                            onChanged: (String value) {
                              setState(() {
                                productState = value;
                              });
                            },
                          ),
                        ),
                        Text(
                          "Brand New",
                        )
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(7)),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 20,
                          margin: EdgeInsets.only(right: 20),
                          child: Radio(
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.isEmpty) {
                                return radio;
                              }
                              return thotBlue;
                            }),
                            value: "Fairly Used (1 - 3 Months)",
                            groupValue: productState,
                            onChanged: (String value) {
                              setState(() {
                                productState = value;
                              });
                            },
                          ),
                        ),
                        Text("Fairly Used (1 - 3 Months)")
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(7)),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 20,
                          margin: EdgeInsets.only(right: 20),
                          child: Radio(
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.isEmpty) {
                                return radio;
                              }
                              return thotBlue;
                            }),
                            value: "Used (3 - 6 Months)",
                            groupValue: productState,
                            onChanged: (String value) {
                              setState(() {
                                productState = value;
                              });
                            },
                          ),
                        ),
                        Text("Used (3 - 6 Months)")
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(15)),
                    Container(
                      height: 50,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            // Display loader while firebase add product action is happening
                            setState(() {
                              loading = true;
                            });

                            await DatabaseService(uid: widget.user.uid)
                                .updateProductCatalogue(
                              widget.merchantData.address,
                              widget.merchantData.merchantName,
                              widget.user.uid,
                              productNameController.text.trim(),
                              productPriceController.text.trim(),
                              productImg1,
                              productImg2,
                              productImg3,
                              productState,
                              widget.merchantData.phoneNumber,
                            );
                          }

                          setState(() {
                            loading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Future.delayed(Duration(seconds: 2), () {
                            // 5s over, navigate to a new page
                            Navigator.popAndPushNamed(
                                context, "/authenticationPage");
                          });
                        },
                        child: Text("Next"),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(20)),
                  ],
                ),
              ),
            ),
          );
  }
}
