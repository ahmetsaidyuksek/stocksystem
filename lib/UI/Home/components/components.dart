import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stocksystem/Core/Authentication/authentication.dart';
import 'package:stocksystem/Core/Database/database.dart';
import 'package:stocksystem/Models/product/product_model.dart';

class HomeComponents {
  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text("Home", style: TextStyle(color: Colors.white)),
      elevation: 16,
      backgroundColor: Colors.purple.shade300,
      actions: [
        IconButton(
          onPressed: () {
            Authentication().signOut().then((isAuthenticated) {
              if (isAuthenticated) Navigator.pushNamedAndRemoveUntil(context, "sign_in", (context) => false);
            });
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget miniItemCard({double imageHeight = 48, double imageWidth = 48, required Product product}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: imageHeight,
              width: imageWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: Image.network(product.productImageURL).image,
                ),
              ),
            ),
            const SizedBox(width: 16),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${product.productName} - ${product.productSize}",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(text: "\n"),
                  TextSpan(
                    text: product.productBrand,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "Product Stock: ",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: product.productStock.toString(),
                    style: TextStyle(
                      color: product.productStock >= 10
                          ? Colors.green
                          : product.productStock >= 5
                              ? Colors.orange
                              : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Product> getItemList({required Map<String, dynamic> datas}) {
    List<Product> productList = [];

    for (Map<Object?, Object?> data in datas.values) {
      productList.add(Product.fromJson(product: Map<String, dynamic>.from(data)));
    }
    return productList;
  }

  FloatingActionButton floatingActionButton({required BuildContext context}) {
    return FloatingActionButton.extended(
      onPressed: () async {
        String barcode = await FlutterBarcodeScanner.scanBarcode(
          "#000000",
          "Cancel",
          false,
          ScanMode.DEFAULT,
        );

        if (barcode != "-1" && barcode != "") {
          bool checkBarcode = await Database().checkBarcodeExits(barcode: barcode);

          if (checkBarcode) {
            String productUID = await Database().getProductUIDFromBarcode(productBarcode: barcode);

            if (productUID != "") Navigator.pushNamed(context, "/product_details/", arguments: productUID);
          } else {
            Navigator.pushNamed(
              context,
              "/product_create/",
              arguments: barcode,
            );
          }
        }
      },
      icon: const Icon(Icons.barcode_reader),
      label: const Text("Scan Barcode"),
    );
  }
}
