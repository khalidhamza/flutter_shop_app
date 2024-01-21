import 'package:shop_app/models/apis/api_response_model.dart';

class CommonResponseModel extends ApiResponseModel
{
  CommonResponseModel.fromJson(Map<String, dynamic> json)
  {
    status  = json['status'] ?? false;
    message = json['message'] ?? "";
  }
}