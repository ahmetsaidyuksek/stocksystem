import 'package:flutter/material.dart';
import 'package:stocksystem/Core/Database/database.dart';
import 'package:stocksystem/UI/ProductDetails/components/components.dart';

class ProductDetails extends StatefulWidget {
  final String productUID;
  const ProductDetails({super.key, required this.productUID});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProductDetailsComponents().appBar(context: context),
      backgroundColor: Colors.blueGrey.shade200,
      body: FutureBuilder(
        future: Database().getProductFromUID(productUID: widget.productUID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
          if (snapshot.hasError) return Text("Error: ${snapshot.error.toString()}");
          if (snapshot.hasData) return ProductDetailsComponents().productDetails(product: snapshot.data!);

          return Text("Error: ${snapshot.error.toString()}");
        },
      ),
    );
  }
}
