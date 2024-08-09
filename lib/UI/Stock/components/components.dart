import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stocksystem/Models/product/product_model.dart';
import 'package:stocksystem/Provider/Stock/stock.dart';

class StockComponents {
  AppBar appBar() {
    return AppBar(
      title: const Text("Stock"),
    );
  }

  Widget productCard({required Product product, required BuildContext context, required int index}) {
    return SizedBox(
      height: 96,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 16,
        color: Colors.blueGrey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 16),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: Image.network(product.productImageURL).image,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Product Name: ${product.productName}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Product Size: ${product.productSize}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Product Brand: ${product.productBrand}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "Stock: ${product.productStock}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            IconButton(
              onPressed: () {
                context.read<StockProvider>().removeProduct(product.productUID, index);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
