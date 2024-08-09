import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocksystem/Provider/Stock/stock.dart';
import 'package:stocksystem/UI/Stock/components/components.dart';

class Stock extends StatelessWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context.read<StockProvider>().getProductList());

    return Consumer<StockProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: StockComponents().appBar(),
          body: ListView.builder(
            itemCount: value.productList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/product_details/",
                    arguments: value.productList[index].productUID,
                  );
                },
                child: StockComponents().productCard(product: value.productList[index], context: context, index: index),
              );
            },
          ),
        );
      },
    );
  }
}
