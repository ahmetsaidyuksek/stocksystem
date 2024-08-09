import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:stocksystem/Core/Authentication/authentication.dart';
import 'package:stocksystem/Models/product/product_model.dart';
import 'package:stocksystem/UI/Home/components/components.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeComponents().appBar(context),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width - 32,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.purpleAccent.shade200,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "View Stock",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const Divider(indent: 6, endIndent: 6),
                      Expanded(
                        child: FutureBuilder(
                          future: FirebaseDatabase.instance.ref("/${Authentication().firebaseAuth.currentUser!.uid}/products/").orderByChild("productStock").once(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
                            if (snapshot.connectionState == ConnectionState.none) return const Text("Connection Error Please Contact Support", style: TextStyle(color: Colors.red));

                            if (snapshot.data!.snapshot.value != null) {
                              List<Product> productList = HomeComponents().getItemList(datas: Map<String, dynamic>.from(snapshot.data?.snapshot.value as Map<Object?, Object?>));

                              return ListView.builder(
                                itemCount: productList.length,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/product_details/",
                                      arguments: productList[index].productUID.toString(),
                                    );
                                  },
                                  child: HomeComponents().miniItemCard(
                                    product: productList[index],
                                  ),
                                ),
                              );
                            }

                            return const Text(
                              "There is no Stock",
                              style: TextStyle(color: Colors.black),
                            );
                          },
                        ),
                      ),
                      const Divider(indent: 6, endIndent: 6),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/stock/",
                          );
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text("View Stock"),
                                  Spacer(),
                                  Icon(Icons.arrow_right_rounded),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: HomeComponents().floatingActionButton(context: context),
    );
  }
}
