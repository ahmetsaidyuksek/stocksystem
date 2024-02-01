import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String barcodeNumber;
  const ProductDetails({Key? key, required this.barcodeNumber}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String productName = "";
  String productCategory = "";
  String productStock = "";
  String productColor = "";
  String productDesign = "";
  String productWidth = "";
  String productQuality = "";
  List productBarcodeNumbers = [];
  List productBarcodeNumbersValues = [];
  getData() {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

    firebaseDatabase.ref("products").orderByChild(widget.barcodeNumber).once().then((value) {
      if (value.snapshot.exists) {
        Map.from(value.snapshot.value as dynamic).forEach((key, value) {
          Map.from(value["barcodeNumbers"]).forEach((key2, value2) {
            if (widget.barcodeNumber.toString() == key2.toString()) {
              setState(() {
                productName = value["productName"].toString();
                productColor = value["productColor"].toString();
                productStock = value["productStock"].toString();
                productWidth = value["productWidth"].toString();
                productDesign = value["productDesign"].toString();
                productQuality = value["productQuality"].toString();
                productCategory = value["productCategory"].toString();
                Map.from(value["barcodeNumbers"]).forEach((key, value) {
                  productBarcodeNumbers.add(key);
                  productBarcodeNumbersValues.add(value);
                });
              });
            }
          });
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ürün detayları"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ürün adı: " + productName,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Ürün rengi: " + productColor,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Ürün dizaynı: " + productDesign,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Ürün stok: " + productStock + " metre",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Ürün kalitesi: " + productQuality,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Ürün genişliği: " + productWidth,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Ürün kategorisi: " + productCategory,
                style: TextStyle(fontSize: 18),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "Ürün'e kayıtlı olan barkodlar:",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: productBarcodeNumbers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        productBarcodeNumbers[index].toString() + " : " + productBarcodeNumbersValues[index].toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
