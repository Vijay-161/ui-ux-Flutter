class CartEntity {
  final String? cartId;
  final String userId;
  final String productId;
  final String name;
  final String image;
  final int price;
  final int? quantity;

  CartEntity({
    this.cartId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    this.quantity,
  });
}
