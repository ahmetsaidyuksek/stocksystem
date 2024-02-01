import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:stocksystem/add_product/add_product.dart';
import 'package:stocksystem/add_stock/add_stock.dart';
import 'package:stocksystem/delete_product.dart/delete_product.dart';
import 'package:stocksystem/delete_stock/delete_stock.dart';
import 'package:stocksystem/product_details/product_details.dart';
import 'package:stocksystem/select_product_category/select_product_category.dart';
import 'package:stocksystem/view_stock/view_stock.dart';

class StockSystemHome extends StatefulWidget {
  final String companyName;
  const StockSystemHome({Key? key, required this.companyName}) : super(key: key);

  @override
  State<StockSystemHome> createState() => _StockSystemHomeState();
}

class _StockSystemHomeState extends State<StockSystemHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(107, 134, 166, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.companyName + " Stok Takip Sistemi",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                FlutterBarcodeScanner.scanBarcode("#000000", "Geri", true, ScanMode.DEFAULT).then((value) {
                  if (value.isNotEmpty && value != "-1") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDetails(
                            barcodeNumber: value,
                          );
                        },
                      ),
                    );
                  }
                });
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Ürün tara",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ViewStock();
                    },
                  ),
                );
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Stokları görüntüle",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    FlutterBarcodeScanner.scanBarcode("#000000", "Geri", true, ScanMode.DEFAULT).then((value) {
                      if (value.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AddStock(productBarcode: value);
                            },
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            "Stok ekle",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    FlutterBarcodeScanner.scanBarcode("#000000", "Geri", true, ScanMode.DEFAULT).then((value) {
                      if (value.isNotEmpty && value != "-1") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DeleteStock(
                                productBarcode: value,
                              );
                            },
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          Text(
                            "Stok sil",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SelectProductCategory();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            "Ürün ekle",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    FlutterBarcodeScanner.scanBarcode("#000000", "Geri", true, ScanMode.DEFAULT).then((value) {
                      if (value.isNotEmpty && value != "-1") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DeleteProduct(
                                barcodeNumber: value,
                              );
                            },
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                          Text(
                            "Ürün sil",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
