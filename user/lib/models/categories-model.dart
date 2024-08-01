class Category {
  String categoryID;
  String? description;

  Category({
    required this.categoryID,
    this.description,
  });

  // Factory method to create a Category object from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryID: json['CategoryID'],
      description: json['Description'],
    );
  }

  // Method to convert a Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      'CategoryID': categoryID,
      'Description': description,
    };
  }

  // Method to create a list of Category objects from JSON
  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }

  // Method to convert a list of Category objects to JSON
  static List<Map<String, dynamic>> toJsonList(List<Category> categories) {
    return categories.map((category) => category.toJson()).toList();
  }
}
