import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:multi_store/auth/customer_login.dart';
import 'package:multi_store/auth/customer_signup.dart';
import 'package:multi_store/auth/supplier_login.dart';
import 'package:multi_store/auth/supplier_signup.dart';
import 'package:multi_store/main_screens/customer_home.dart';
import 'package:multi_store/main_screens/onboarding_screen.dart';
import 'package:multi_store/main_screens/supplier_home.dart';
import 'package:multi_store/main_screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multi_store/providers/cart_provider.dart';
import 'package:multi_store/providers/stripe_id.dart';
import 'package:multi_store/providers/wish_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
    ChangeNotifierProvider(create: (_) => Wish()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboarding_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/onboarding_screen': (context) => const Onboardingscreen(),
        '/customer_home': (context) => const CustomerHomeScreen(),
        '/supplier_home': (context) => const SupplierHomeScreen(),
        '/customer_signup': (context) => const CustomerRegister(),
        '/customer_login': (context) => const CustomerLogin(),
        '/supplier_signup': (context) => const SupplierRegister(),
        '/supplier_login': (context) => const SupplierLogin(),
      },
    );
  }
}
