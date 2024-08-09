import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stocksystem/Core/Authentication/authentication.dart';
import 'package:stocksystem/Models/product/product_model.dart';

class Database {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<bool> productDelete({required String productUID}) async {
    try {
      await firebaseDatabase.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products/$productUID/").remove();
      await firebaseStorage.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products/$productUID/").delete();

      return true;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Product Delete Error: $error",
        toastLength: Toast.LENGTH_LONG,
      );
    }

    return false;
  }

  Future<String> uploadProductImage({required File file, required String productUID}) async {
    try {
      Reference reference = firebaseStorage.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products/").child(productUID);

      TaskSnapshot taskSnapshot = await reference.putFile(file);

      if (taskSnapshot.state == TaskState.success) return await reference.getDownloadURL();

      return "";
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Product Image Upload Error: $error",
        toastLength: Toast.LENGTH_LONG,
      );

      return "";
    }
  }

  Future<String> createProduct({required Product product}) async {
    try {
      DatabaseReference databaseReference = firebaseDatabase.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products").push();

      product.productUID = databaseReference.key.toString();

      await databaseReference.set(product.productToJson());

      return databaseReference.key!;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error Product Create: $error",
        toastLength: Toast.LENGTH_LONG,
      );
      return "";
    }
  }

  Future<bool> checkBarcodeExits({required String barcode}) async {
    bool checkBarcode = false;

    try {
      DataSnapshot dataSnapshot = await firebaseDatabase.ref("${Authentication().firebaseAuth.currentUser!.uid}/products").get();

      if (dataSnapshot.value == null) return false;

      Map<String, dynamic> products = Map<String, dynamic>.from(dataSnapshot.value as Map<Object?, Object?>);

      if (dataSnapshot.exists) {
        for (var data in products.values) {
          if (data["productBarcode"] == barcode) checkBarcode = true;
        }
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error While Check Barcode: ${error.toString()}",
        toastLength: Toast.LENGTH_LONG,
      );
      checkBarcode = false;
    }

    return checkBarcode;
  }

  Future<String> getProductUIDFromBarcode({required String productBarcode}) async {
    try {
      DataSnapshot dataSnapshot = await firebaseDatabase.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products/").get();

      Map<String, dynamic> products = Map<String, dynamic>.from(dataSnapshot.value as Map<Object?, Object?>);

      if (dataSnapshot.exists) {
        for (var data in products.values) {
          if (data["productBarcode"] == productBarcode) return data["productUID"];
        }
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Get Product Data Error: ${error.toString()}",
        toastLength: Toast.LENGTH_LONG,
      );

      return "";
    }
    return "";
  }

  Future<Product?> getProductFromUID({required String productUID}) async {
    try {
      DataSnapshot dataSnapshot = await firebaseDatabase.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products/$productUID/").get();

      Product product = Product.fromJson(product: Map<String, dynamic>.from(dataSnapshot.value as Map<Object?, Object?>));

      return product;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Get Product Data Error: ${error.toString()}",
        toastLength: Toast.LENGTH_LONG,
      );
    }
    return null;
  }

  Future<bool> createUserFirestore({
    required String name,
    required int phoneNumber,
    required String email,
  }) async {
    if (Authentication().firebaseAuth.currentUser != null) {
      try {
        await firebaseFirestore.collection("users").doc(Authentication().firebaseAuth.currentUser!.uid).set({
          "name": name,
          "phoneNumber": phoneNumber,
          "email": email,
          "creationDate": DateTime.now().millisecondsSinceEpoch,
        });

        return true;
      } catch (error) {
        Fluttertoast.showToast(
          msg: "Auth Create Error: $error",
          toastLength: Toast.LENGTH_LONG,
        );

        return false;
      }
    }

    return false;
  }
}
