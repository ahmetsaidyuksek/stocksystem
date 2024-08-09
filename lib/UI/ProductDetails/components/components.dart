import 'package:flutter/material.dart';
import 'package:stocksystem/Models/product/product_model.dart';

class ProductDetailsComponents {
  AppBar appBar({required BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.blueGrey.shade300,
      elevation: 16,
      title: const Text("Product Details"),
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/",
            (value) => false,
          );
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget productDetails({required Product product}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                  left: 24,
                ),
                child: Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.blueAccent.shade200,
                      ),
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: Image.network(product.productImageURL).image,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Name: ${product.productName}",
                      style: const TextStyle(
                        fontSize: 18,
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
              ),
            ],
          ),
          const SizedBox(height: 64),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  height: 128,
                  width: 128,
                  child: Card(
                    color: Colors.deepPurple.shade400,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Add Stock",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Icon(
                          Icons.barcode_reader,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  height: 128,
                  width: 128,
                  child: Card(
                    color: Colors.deepPurple.shade400,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Delete Stock",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        Icon(
                          Icons.barcode_reader,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
