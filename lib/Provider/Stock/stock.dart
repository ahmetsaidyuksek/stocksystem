import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:stocksystem/Core/Authentication/authentication.dart';
import 'package:stocksystem/Core/Database/database.dart';
import 'package:stocksystem/Models/product/product_model.dart';

class StockProvider extends ChangeNotifier {
  List<Product> productList = [];

  removeProduct(productUID, index) async {
    bool productDelete = await Database().productDelete(productUID: productUID);

    if (productDelete) {
      productList.removeAt(index);
      notifyListeners();
    }
  }

  getProductList() async {
    productList = [];
    notifyListeners();

    DataSnapshot dataSnapshot = await Database().firebaseDatabase.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products/").get();

    if (dataSnapshot.exists) {
      Map<String, dynamic> productMap = Map<String, dynamic>.from(dataSnapshot.value as Map<Object?, Object?>);

      productMap.forEach((key, value) {
        productList.add(Product.fromJson(
          product: Map<String, dynamic>.from(value as Map<Object?, Object?>),
        ));
        notifyListeners();
      });
    }
  }
}
