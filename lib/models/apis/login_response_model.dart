import 'package:shop_app/models/apis/api_response_model.dart';
import 'package:shop_app/models/user_model.dart';

class LoginResponseModel extends ApiResponseModel
{
  late UserModel? date;

  LoginResponseModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    date = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }
}