import 'package:flutter/material.dart';
import 'package:stocksystem/add_product/add_product.dart';

class SelectProductCategory extends StatefulWidget {
  const SelectProductCategory({Key? key}) : super(key: key);

  @override
  State<SelectProductCategory> createState() => _SelectProductCategoryState();
}

class _SelectProductCategoryState extends State<SelectProductCategory> {
  List categories = ["Perde"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ürün kategorisini seç"),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.indigo.shade300,
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddProduct(
                        productCategory: categories[index].toString().toLowerCase(),
                      );
                    },
                  ),
                );
              },
              title: Center(
                child: Text(
                  categories[index],
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
