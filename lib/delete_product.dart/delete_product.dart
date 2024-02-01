import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:stocksystem/stock_system_home/stock_system_home.dart';

class DeleteProduct extends StatefulWidget {
  final String barcodeNumber;
  const DeleteProduct({Key? key, required this.barcodeNumber}) : super(key: key);

  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  String productID = "";

  getProduct() {
    firebaseDatabase.ref("products").orderByChild(widget.barcodeNumber).once().then((value) {
      if (value.snapshot.exists) {
        Map.from(value.snapshot.value as dynamic).forEach((key, value) {
          Map.from(value["barcodeNumbers"]).forEach((key2, value2) {
            if (widget.barcodeNumber.toString() == key2.toString()) {
              setState(() {
                productID = value["productID"].toString();
                return;
              });
            }
          });
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  deleteProduct() {
    firebaseDatabase.ref("products").orderByChild(widget.barcodeNumber).once().then((value) {
      if (value.snapshot.exists) {
        Map.from(value.snapshot.value as dynamic).forEach((key, value) {
          Map.from(value["barcodeNumbers"]).forEach((key2, value2) {
            if (widget.barcodeNumber.toString() == key2.toString()) {
              firebaseDatabase.ref("products").child(value["productID"]).remove().then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const StockSystemHome(companyName: "Liva Tekstil");
                    },
                  ),
                  (route) => false,
                );
              });
            }
          });
        });
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ürün sil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                "Ürün kodu: " + productID,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      deleteProduct();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 32,
                          ),
                          Text(
                            "Ürünü sil",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 32,
                          ),
                          Text(
                            "İptal",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
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
}
