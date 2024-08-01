import '../models/categories-model.dart'; // Mengimpor model Category

class Product {
  String productID;
  String productName;
  Category category; // Menggunakan model Category
  int qtyProduct;
  int unitPrice;
  String? description;
  String? imageProduct;
  double? ratingProduct;
  String createdBy;
  DateTime? createdDate;

  Product({
    required this.productID,
    required this.productName,
    required this.category,
    required this.qtyProduct,
    required this.unitPrice,
    this.description,
    this.imageProduct,
    this.ratingProduct,
    required this.createdBy,
    this.createdDate,
  });

  // Factory method to create a Product object from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: json['ProductID'],
      productName: json['ProductName'],
      category: Category.fromJson(json['Category']), // Parsing category
      qtyProduct: json['QtyProduct'],
      unitPrice: json['UnitPrice'],
      description: json['Description'],
      imageProduct: json['ImageProduct'],
      ratingProduct: (json['RatingProduct'] != null) ? double.parse(json['RatingProduct']) : null,
      createdBy: json['CreatedBy'],
      createdDate: (json['CreatedDate'] != null) ? DateTime.parse(json['CreatedDate']) : null,
    );
  }

  // Method to convert a Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'ProductID': productID,
      'ProductName': productName,
      'Category': category.toJson(), // Mengonversi category ke JSON
      'QtyProduct': qtyProduct,
      'UnitPrice': unitPrice,
      'Description': description,
      'ImageProduct': imageProduct,
      'RatingProduct': ratingProduct?.toString(),
      'CreatedBy': createdBy,
      'CreatedDate': createdDate?.toIso8601String(),
    };
  }

  // Method to create a list of Product objects from JSON
  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  // Method to convert a list of Product objects to JSON
  static List<Map<String, dynamic>> toJsonList(List<Product> products) {
    return products.map((product) => product.toJson()).toList();
  }
}
