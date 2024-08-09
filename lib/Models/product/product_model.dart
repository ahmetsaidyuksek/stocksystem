class Product {
  late String productUID;
  late String productName;
  late String productColor;
  late String productSize;
  late String productBrand;
  late String productImageURL;
  late String productBarcode;
  late int productStock;
  final int productCreationDate = DateTime.now().millisecondsSinceEpoch;

  Product({
    required this.productUID,
    required this.productName,
    required this.productColor,
    required this.productSize,
    required this.productBrand,
    required this.productImageURL,
    required this.productBarcode,
    required this.productStock,
  });

  factory Product.fromJson({required Map<String, dynamic> product}) {
    return Product(
      productUID: product["productUID"].toString(),
      productName: product["productName"].toString(),
      productColor: product["productColor"].toString(),
      productSize: product["productSize"].toString(),
      productImageURL: product["productImageURL"].toString(),
      productBrand: product["productBrand"].toString(),
      productBarcode: product["productBarcode"].toString(),
      productStock: int.tryParse(product["productStock"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> productToJson() {
    return {
      "productUID": productUID,
      "productName": productName,
      "productColor": productColor,
      "productSize": productSize,
      "productImageURL": productImageURL,
      "productBrand": productBrand,
      "productBarcode": productBarcode,
      "productStock": productStock,
      "productCreationDate": productCreationDate,
    };
  }
}
