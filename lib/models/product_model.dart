class ProductModel
{
  late int id;
  late String name;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String description;
  late List<String>? images;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    // images = json['images'].toList();
    inFavorites = json['in_favorites'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}