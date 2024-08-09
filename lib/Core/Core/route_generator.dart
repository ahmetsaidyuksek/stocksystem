import 'package:flutter/material.dart';
import 'package:stocksystem/UI/Authentication/sign_in/sign_in.dart';
import 'package:stocksystem/UI/Authentication/sign_up/sign_up.dart';
import 'package:stocksystem/UI/Home/home.dart';
import 'package:stocksystem/UI/ProductCreate/product_create.dart';
import 'package:stocksystem/UI/ProductDetails/product_details.dart';
import 'package:stocksystem/UI/Stock/stock.dart';

class RouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const Home());
      case "sign_in":
        return MaterialPageRoute(builder: (_) => const SignIn());
      case "sign_up":
        return MaterialPageRoute(builder: (_) => const SignUp());
      case "/stock/":
        return MaterialPageRoute(builder: (_) => const Stock());
      case "/product_create/":
        if (routeSettings.arguments is String) return MaterialPageRoute(builder: (_) => ProductCreate(productBarcode: routeSettings.arguments as String));

        return MaterialPageRoute(builder: (_) => const ErrorPage());
      case "/product_details/":
        if (routeSettings.arguments is String) return MaterialPageRoute(builder: (_) => ProductDetails(productUID: routeSettings.arguments as String));

        return MaterialPageRoute(builder: (_) => const ErrorPage());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Something wrong",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
