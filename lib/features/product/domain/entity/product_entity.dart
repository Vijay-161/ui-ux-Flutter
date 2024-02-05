class ProductEntity {
  final String? productId;
  final String productName;
  final String? productImage;
  final int price;
  final String category;
  final String desc;

  ProductEntity({
    this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.category,
    required this.desc,
  });
}
