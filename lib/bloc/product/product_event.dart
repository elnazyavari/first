abstract class ProductEvent {}

class ProductInitialEvent extends ProductEvent {
  final String productId;
  final String productCategoryId;
  ProductInitialEvent({required this.productId, required this.productCategoryId});
}
