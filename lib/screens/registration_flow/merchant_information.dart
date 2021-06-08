import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:project_zora/shared/constants.dart';

class RegistrationMerchantInformation extends StatelessWidget {
  // Form Text fields
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Initial default phone number
  final PhoneNumber number = PhoneNumber(isoCode: 'RW');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: thotBlue,
                    thickness: 2,
                  )),
                  Padding(padding: const EdgeInsets.all(3)),
                  Expanded(
                      child: Divider(
                    color: vanillaBaby,
                    thickness: 2,
                  )),
                  Padding(padding: const EdgeInsets.all(3)),
                  Expanded(
                      child: Divider(
                    color: vanillaBaby,
                    thickness: 2,
                  )),
                ],
              ),
              Padding(padding: const EdgeInsets.all(10)),
              Text(
                "First\nLet's get to know your\nshop",
                style: TextStyle(
                  color: fontType,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: const EdgeInsets.all(20)),
              Text(
                "SHOP NAME",
                style: TextStyle(
                  color: grey,
                  fontSize: 12,
                ),
              ),
              Padding(padding: const EdgeInsets.all(5)),
              TextFormField(
                  controller: shopNameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter your shop name";
                    }
                    return null;
                  },
                  decoration: registrationInputDecoration),
              Padding(padding: const EdgeInsets.all(10)),
              Text(
                "EMAIL",
                style: TextStyle(
                  color: grey,
                  fontSize: 12,
                ),
              ),
              Padding(padding: const EdgeInsets.all(5)),
              TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty || !value.contains("@")) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  decoration: registrationInputDecoration),
              Padding(padding: const EdgeInsets.all(10)),
              Text(
                "PHONE",
                style: TextStyle(
                  color: grey,
                  fontSize: 12,
                ),
              ),
              Padding(padding: const EdgeInsets.all(5)),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  print(value);
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: phoneNumberController,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                inputDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: vanillaBaby, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Colors.blue, width: 1.5))),
              ),
              Padding(padding: const EdgeInsets.all(60)),
              Container(
                height: 50,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pushNamed(
                          context, "/registrationMerchantPassword",
                          arguments: {
                            "shopName": shopNameController.text.trim(),
                            "emailAddress": emailController.text.trim(),
                            "phoneNumber": phoneNumberController.text.trim()
                          });
                    }
                  },
                  child: Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
