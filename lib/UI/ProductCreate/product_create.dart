import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:stocksystem/Core/Authentication/authentication.dart';
import 'package:stocksystem/Core/Database/database.dart';
import 'package:stocksystem/Models/product/product_model.dart';
import 'package:stocksystem/Provider/ImagePicker/image_picker.dart';
import 'package:stocksystem/UI/ProductCreate/components/components.dart';

class ProductCreate extends StatefulWidget {
  final String productBarcode;
  const ProductCreate({super.key, required this.productBarcode});

  @override
  State<ProductCreate> createState() => _ProductCreateState();
}

class _ProductCreateState extends State<ProductCreate> {
  static TextEditingController productNameController = TextEditingController();
  static TextEditingController productSizeController = TextEditingController();
  static TextEditingController productBrandController = TextEditingController();
  static TextEditingController productStockController = TextEditingController();
  static TextEditingController productColorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ImagePickerModel>().setFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePickerModel>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: ProductCreateComponents().appBar(context: context),
          backgroundColor: Colors.grey.shade200,
          body: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    var imagePick = context.read<ImagePickerModel>();

                    imagePick.pickImage();
                  },
                  child: Container(
                    height: 192,
                    width: 192,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(blurRadius: 4),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: value.file != null ? Image.file(value.file!).image : Image.asset("assets/images/stocksystem_image_add.png").image,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: TextFormField(
                    controller: productNameController,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: "Product Name",
                      hintText: "Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: TextFormField(
                    controller: productSizeController,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: "Product Size",
                      hintText: "Product Size",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: TextFormField(
                    controller: productBrandController,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: "Product Brand",
                      hintText: "Product Brand",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: TextFormField(
                    controller: productStockController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: "Product Stock",
                      hintText: "Product Stock",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: TextField(
                    controller: productColorController,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: "Product Color",
                      hintText: "Product Color",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () async {
                    String productUID = await Database().createProduct(
                      product: Product.fromJson(product: {
                        "productName": productNameController.text.toString(),
                        "productColor": productColorController.text.toString(),
                        "productSize": productSizeController.text.toString(),
                        "productBrand": productBrandController.text.toString(),
                        "productBarcode": widget.productBarcode.toString(),
                        "productStock": productStockController.text.toString(),
                      }),
                    );

                    if (productUID != "") {
                      if (value.file != null) {
                        try {
                          String productImageURL = await Database().uploadProductImage(file: value.file!, productUID: productUID);

                          Database().firebaseDatabase.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products/$productUID/").update({
                            "productImageURL": productImageURL,
                          });
                        } catch (error) {
                          Fluttertoast.showToast(
                            msg: "Error: $error",
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      }

                      Navigator.pushNamed(
                        context,
                        "/product_details/",
                        arguments: productUID,
                      );
                    }
                  },
                  child: const Text("Create Product"),
                ),
              ])),
            ),
          ),
        );
      },
    );
  }
}
