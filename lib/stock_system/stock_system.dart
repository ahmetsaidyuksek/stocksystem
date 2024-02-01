import 'package:flutter/material.dart';
import 'package:stocksystem/stock_system_home/stock_system_home.dart';

class StockSystem extends StatefulWidget {
  final String companyName;
  const StockSystem({Key? key, required this.companyName}) : super(key: key);

  @override
  State<StockSystem> createState() => _StockSystemState();
}

class _StockSystemState extends State<StockSystem> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StockSystemHome(companyName: widget.companyName),
    );
  }
}
