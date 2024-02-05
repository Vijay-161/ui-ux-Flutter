import '../../domain/entity/product_entity.dart';

class ProductState {
  final bool isLoading;
  final List<ProductEntity> products;
  final String? error;
  final String? imageName;
  final ProductEntity singleProduct;
  final ProductEntity? editProduct;

  ProductState({
    required this.isLoading,
    required this.products,
    this.error,
    this.imageName,
    required this.singleProduct,
    this.editProduct,
  });

  factory ProductState.initial() {
    return ProductState(
      isLoading: false,
      products: [],
      imageName: null,
      singleProduct:
          ProductEntity(productName: 'ddd', price: 333, category: 'Men', desc: 'Fake'),
      editProduct: null,
    );
  }

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    String? error,
    String? imageName,
    ProductEntity? singleProduct,
    ProductEntity? editProduct,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      singleProduct: singleProduct ?? this.singleProduct,
      editProduct: editProduct ?? this.editProduct
    );
  }
}
