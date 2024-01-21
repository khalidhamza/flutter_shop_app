class UserModel
{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
  int? points;
  int? credit;

  UserModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'] ?? 0;
    credit = json['credit'] ?? 0;
    token = json['token'];
  }
}