class CategoryModel
{
  late int id;
  late String name;
  late String image;

  CategoryModel.fromJson(Map<String, dynamic> json)
  {
    id    = json['id'] ?? 0;
    name  = json['name'] ?? "";
    image = json['image'] ?? "";
  }
}