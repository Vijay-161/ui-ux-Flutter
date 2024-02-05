class OrderEntity {
  final String? orderId;
  final String userId;
  final String productId;
  final String name;
  final String image;
  final int price;
  final int? quantity;
  final String username;
  final bool payment;

  OrderEntity({
    this.orderId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    this.quantity,
    required this.username,
    required this.payment,
  });
}
