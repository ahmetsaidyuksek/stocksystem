import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stocksystem/product_details/product_details.dart';

class AddProduct extends StatefulWidget {
  final String productCategory;
  const AddProduct({Key? key, required this.productCategory}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productWidthController = TextEditingController();
  TextEditingController productStockController = TextEditingController();
  TextEditingController productColorController = TextEditingController();
  TextEditingController productDesignController = TextEditingController();
  TextEditingController productQualityController = TextEditingController();

  void addProduct() {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    DatabaseReference databaseReference = firebaseDatabase.ref("products").push();

    Map<String, dynamic> barcodeNumbers = {};
    for (var element in listDynamic) {
      if (element.barcodeNumberController.text.isNotEmpty && element.lengthController.text.isNotEmpty) {
        barcodeNumbers.addAll({
          element.barcodeNumberController.text.toString(): int.parse(element.lengthController.text.toString()),
        });
      }
    }

    databaseReference.set({
      "productName": productNameController.text.toString(),
      "productWidth": productWidthController.text.toString(),
      "productColor": productColorController.text.toString(),
      "productDesign": productDesignController.text.toString(),
      "productQuality": productQualityController.text.toString(),
      "productCategory": widget.productCategory.toString(),
      "productID": databaseReference.key.toString(),
      "productStock": productStockController.text.toString(),
    }).then((value) {
      databaseReference.child("barcodeNumbers").update(barcodeNumbers).then((value) {
        Fluttertoast.showToast(
          msg: "Başarılı bir şekilde yeni ürün eklendi",
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetails(
                barcodeNumber: barcodeNumbers.keys.first.toString(),
              );
            },
          ),
        );
      }).catchError((error) {
        Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_LONG,
        );
      });
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_LONG,
      );
    });
  }

  List<DynmaicWidget> listDynamic = [];
  addNewBarcodeField() {
    if (listDynamic.length >= 5) {
      return;
    }
    setState(() {
      listDynamic.add(DynmaicWidget());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ürün ekle"),
        actions: [
          IconButton(
            onPressed: () {
              addNewBarcodeField();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: productNameController,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Ürün adı",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: productWidthController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Ürün genişliği (CM)",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: productStockController,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Mevcut ürün stok (METRE)",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: productColorController,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Ürün rengi",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: productDesignController,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Ürün dizaynı",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: productQualityController,
                  maxLines: 1,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Ürün kalitesi",
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: listDynamic.length,
                itemBuilder: (context, index) {
                  return listDynamic[index];
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    addProduct();
                  },
                  child: const Text(
                    "Ürünü yükle",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DynmaicWidget extends StatelessWidget {
  DynmaicWidget({Key? key}) : super(key: key);

  TextEditingController barcodeNumberController = TextEditingController();
  TextEditingController lengthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextField(
            controller: barcodeNumberController,
            decoration: InputDecoration(
              hintText: "Barkod numarasını giriniz",
              suffixIcon: IconButton(
                onPressed: () async {
                  barcodeNumberController.text = await FlutterBarcodeScanner.scanBarcode(
                    "#000000",
                    "İptal",
                    true,
                    ScanMode.DEFAULT,
                  );
                },
                icon: const Icon(Icons.qr_code_scanner),
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: lengthController,
          ),
        ),
      ],
    );
  }
}
