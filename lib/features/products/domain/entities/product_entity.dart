class ProductEntity {
  final int id;
  final int price;
  final String name;
  final String imageUrl;

  ProductEntity({
    required this.id,
    required this.price,
    required this.name,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'ProductEntity(id: $id, price: $price, name: $name, imageUrl: $imageUrl)';
  }
}
