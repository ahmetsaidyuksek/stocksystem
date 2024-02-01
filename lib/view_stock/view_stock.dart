import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:stocksystem/product_details/product_details.dart';

class ViewStock extends StatefulWidget {
  const ViewStock({Key? key}) : super(key: key);

  @override
  State<ViewStock> createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Stokları görüntüle"),
      ),
      body: Center(
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref("products"),
          itemBuilder: (context, dataSnapshot, animatoin, index) {
            String productName = "";
            String productColor = "";
            String productStock = "";
            String productDesign = "";
            String productCategory = "";
            String productQuality = "";
            String productWidth = "";
            String productBarcode = "";
            Map.from(dataSnapshot.value as dynamic).forEach((key, value) {
              if (key == "productName") {
                productName = value.toString();
              } else if (key == "productColor") {
                productColor = value.toString();
              } else if (key == "productStock") {
                productStock = value.toString();
              } else if (key == "productDesign") {
                productDesign = value.toString();
              } else if (key == "productCategory") {
                productCategory = value.toString();
              } else if (key == "productQuality") {
                productQuality = value.toString();
              } else if (key == "productWidth") {
                productWidth = value.toString();
              } else if (key == "barcodeNumbers") {
                Map.from(value).forEach((key2, value2) {
                  productBarcode = key2;
                });
              }
            });
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetails(barcodeNumber: productBarcode);
                          },
                        ),
                      );
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("İsim: " + productName),
                        Text("Renk: " + productColor),
                        Text("Stok: " + productStock + " metre"),
                        Text("Kalite: " + productQuality),
                        Text("Kategori: " + productCategory),
                        Text("Genişlik: " + productWidth),
                        Text("Dizayn: " + productDesign),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
