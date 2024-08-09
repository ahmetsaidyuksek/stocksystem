import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocksystem/Core/Authentication/authentication.dart';
import 'package:stocksystem/Core/Core/route_generator.dart';
import 'package:stocksystem/Provider/ImagePicker/image_picker.dart';
import 'package:stocksystem/Provider/Stock/stock.dart';
import 'package:stocksystem/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Authentication().authenticationInitialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagePickerModel()),
        ChangeNotifierProvider(create: (context) => StockProvider()),
      ],
      child: const StockSystem(),
    ),
  );
}

class StockSystem extends StatelessWidget {
  const StockSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Authentication().isAuthenticated ? "/" : "sign_in",
      themeMode: ThemeMode.system,
      title: "StockSystem",
      onGenerateRoute: RouteGenerator.routeGenerator,
    );
  }
}
