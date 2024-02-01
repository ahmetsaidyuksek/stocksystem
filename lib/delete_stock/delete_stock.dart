import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:stocksystem/stock_system_home/stock_system_home.dart';

class DeleteStock extends StatefulWidget {
  final String productBarcode;
  const DeleteStock({Key? key, required this.productBarcode}) : super(key: key);

  @override
  State<DeleteStock> createState() => _DeleteStockState();
}

class _DeleteStockState extends State<DeleteStock> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  int productStock = 0;
  int howMuchWillRemove = 0;
  int maxValue = 0;
  String productID = "";

  getProductData() {
    firebaseDatabase.ref("products").orderByChild(widget.productBarcode).once().then((value) {
      if (value.snapshot.exists) {
        Map.from(value.snapshot.value as dynamic).forEach((key, value) {
          Map.from(value["barcodeNumbers"]).forEach((key2, value2) {
            if (widget.productBarcode.toString() == key2.toString()) {
              if (value["productStock"] > 0) {
                setState(() {
                  productID = value["productID"];
                  productStock = value["productStock"];
                  maxValue = productStock;
                  if (value2 < productStock) {
                    howMuchWillRemove = value2;
                  }
                  return;
                });
              } else {
                Navigator.pop(context);
              }
            }
          });
        });
      }
    });
  }

  deleteStock() {
    firebaseDatabase.ref("products").child(productID).update({
      "productStock": (productStock - howMuchWillRemove),
    }).then((value) {
      setState(() {});
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return const StockSystemHome(
            companyName: "Liva Tekstil",
          );
        }),
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Stok sil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Mevcut stok'tan kaç metre düşülecek:",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      child: NumberPicker(
                        minValue: 0,
                        maxValue: maxValue,
                        value: howMuchWillRemove,
                        onChanged: (value) {
                          setState(() {
                            howMuchWillRemove = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 64,
              ),
              child: Center(
                child: Text(
                  "Mevcut stok: " + productStock.toString() + " metre",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    deleteStock();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.check,
                          size: 32,
                          color: Colors.white,
                        ),
                        Text(
                          "Evet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.green,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const StockSystemHome(
                            companyName: "Liva Tekstil",
                          );
                        },
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.close,
                          size: 32,
                          color: Colors.white,
                        ),
                        Text(
                          "İptal",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
