import 'package:shop_app/models/apis/api_response_model.dart';
import 'package:shop_app/models/user_model.dart';

class ProfileResponseModel extends ApiResponseModel
{
  late UserModel? user;

  ProfileResponseModel.fromJson(Map<String, dynamic> json)
  {
    status  = json['status'];
    message = json['message'] ?? "";
    user    = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }
}