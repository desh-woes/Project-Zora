import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_zora/screens/authentication/authenticate.dart';
import 'package:project_zora/screens/landing_page.dart';
import 'package:project_zora/screens/registration_flow/merchant_information.dart';
import 'package:project_zora/screens/registration_flow/merchant_password.dart';
import 'package:project_zora/screens/registration_flow/merchant_profile_pic.dart';
import 'package:project_zora/services/authentication_service.dart';
import 'package:project_zora/shared/constants.dart';
import 'package:project_zora/sign_in_page.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider<User>(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: softWork,
            appBarTheme: AppBarTheme(
              color: softWork,
            )),
        initialRoute: "/",
        routes: {
          "/authenticationPage": (context) => Authenticate(),
          "/registrationMerchantInformation": (context) =>
              RegistrationMerchantInformation(),
          "/registrationProfilePic": (context) => RegistrationProfilePic(),
          "/registrationMerchantPassword": (context) => RegistrationMerchantPassword()
          // "/merchantViewProductPage": (context) => ViewProducts(),
          // "/searchPage": (context) => ShopperLanding(),
        },
        home: LandingPage(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    }

    return SignInPage();
  }
}
