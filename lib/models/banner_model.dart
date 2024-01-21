class BannerModel
{
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'] ?? 0;
    image = json['image'] ?? "";
  }
}